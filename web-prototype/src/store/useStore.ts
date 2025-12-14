import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import {
  User,
  EMSProtocol,
  Medication,
  Procedure,
  UserRole,
  CertificationLevel,
  WeightUnit,
  DoseCalculation,
  DosingProtocol,
  DoseUnit
} from '../types'
import { sampleProtocols, sampleMedications, sampleProcedures } from '../data/sampleData'

interface AppState {
  // Authentication
  currentUser: User | null
  isAuthenticated: boolean
  login: (username: string, password: string) => void
  logout: () => void

  // Data
  protocols: EMSProtocol[]
  medications: Medication[]
  procedures: Procedure[]

  // Dosing Calculator
  patientWeight: number
  weightUnit: WeightUnit
  ageGroup: string
  setPatientWeight: (weight: number, unit: WeightUnit) => void
  convertWeight: (toUnit: WeightUnit) => void

  // Search
  searchQuery: string
  setSearchQuery: (query: string) => void

  // State selection
  selectedState: string
  setSelectedState: (state: string) => void
}

export const useStore = create<AppState>()(
  persist(
    (set, get) => ({
      // Initial state
      currentUser: null,
      isAuthenticated: false,
      protocols: sampleProtocols,
      medications: sampleMedications,
      procedures: sampleProcedures,
      patientWeight: 70,
      weightUnit: WeightUnit.Kg,
      ageGroup: 'Adult',
      searchQuery: '',
      selectedState: 'National',

      // Auth actions
      login: (username: string, _password: string) => {
        const role = username.toLowerCase().includes('editor') ? UserRole.Editor : UserRole.RegularUser

        const user: User = {
          id: Math.random().toString(36).substr(2, 9),
          username,
          email: `${username}@example.com`,
          role,
          certificationLevel: CertificationLevel.Paramedic,
          state: 'CA',
          agency: 'Sample EMS Agency',
          preferredWeightUnit: WeightUnit.Kg,
          createdAt: new Date().toISOString(),
          lastLogin: new Date().toISOString()
        }

        set({ currentUser: user, isAuthenticated: true })
      },

      logout: () => {
        set({ currentUser: null, isAuthenticated: false })
      },

      // Weight actions
      setPatientWeight: (weight: number, unit: WeightUnit) => {
        set({ patientWeight: weight, weightUnit: unit })
      },

      convertWeight: (toUnit: WeightUnit) => {
        const { patientWeight, weightUnit } = get()

        if (weightUnit === toUnit) return

        let newWeight = patientWeight
        if (weightUnit === WeightUnit.Kg && toUnit === WeightUnit.Lbs) {
          newWeight = patientWeight * 2.20462
        } else if (weightUnit === WeightUnit.Lbs && toUnit === WeightUnit.Kg) {
          newWeight = patientWeight / 2.20462
        }

        set({ patientWeight: newWeight, weightUnit: toUnit })
      },

      // Search
      setSearchQuery: (query: string) => {
        set({ searchQuery: query })
      },

      // State selection
      setSelectedState: (state: string) => {
        set({ selectedState: state })
      }
    }),
    {
      name: 'ems-protocol-storage',
      partialize: (state) => ({
        currentUser: state.currentUser,
        isAuthenticated: state.isAuthenticated,
        patientWeight: state.patientWeight,
        weightUnit: state.weightUnit,
        selectedState: state.selectedState
      })
    }
  )
)

// Helper functions
export const calculateDose = (dosingProtocol: DosingProtocol, weightInKg: number): DoseCalculation => {
  let dose = dosingProtocol.amount

  if (dosingProtocol.weightBased) {
    dose = dosingProtocol.amount * weightInKg
    if (dosingProtocol.maxDose && dose > dosingProtocol.maxDose) {
      dose = dosingProtocol.maxDose
    }
  }

  return {
    id: Math.random().toString(36).substr(2, 9),
    medication: '',
    dose,
    unit: dosingProtocol.unit,
    patientWeight: weightInKg,
    weightUnit: WeightUnit.Kg,
    instructions: dosingProtocol.instructions,
    maxDose: dosingProtocol.maxDose,
    isMaxDoseReached: dosingProtocol.maxDose ? dose >= dosingProtocol.maxDose : false
  }
}
