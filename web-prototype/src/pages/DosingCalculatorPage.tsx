import { useState } from 'react'
import { useStore } from '../store/useStore'
import { calculateDose } from '../store/useStore'
import { WeightUnit, AgeGroup, Medication } from '../types'
import { Scale, AlertTriangle } from 'lucide-react'

const DosingCalculatorPage = () => {
  const { patientWeight, weightUnit, setPatientWeight, convertWeight, medications } = useStore()
  const [weightInput, setWeightInput] = useState(patientWeight.toString())
  const [selectedAgeGroup, setSelectedAgeGroup] = useState<AgeGroup>(AgeGroup.Adult)
  const [selectedMedication, setSelectedMedication] = useState<Medication | null>(null)

  const handleWeightChange = (value: string) => {
    setWeightInput(value)
    const numValue = parseFloat(value)
    if (!isNaN(numValue)) {
      setPatientWeight(numValue, weightUnit)
    }
  }

  const handleUnitToggle = () => {
    const newUnit = weightUnit === WeightUnit.Kg ? WeightUnit.Lbs : WeightUnit.Kg
    convertWeight(newUnit)
    setWeightInput(useStore.getState().patientWeight.toFixed(1))
  }

  const applyPreset = (ageGroup: AgeGroup) => {
    setSelectedAgeGroup(ageGroup)
    const presets = {
      [AgeGroup.Neonate]: 3.5,
      [AgeGroup.Infant]: 7.0,
      [AgeGroup.Child]: 20.0,
      [AgeGroup.Adolescent]: 50.0,
      [AgeGroup.Adult]: 70.0,
      [AgeGroup.Geriatric]: 70.0
    }
    setPatientWeight(presets[ageGroup], WeightUnit.Kg)
    setWeightInput(presets[ageGroup].toString())
  }

  const weightInKg = weightUnit === WeightUnit.Kg ? patientWeight : patientWeight / 2.20462

  const doses = selectedMedication
    ? selectedMedication.dosing
        .filter((d) => d.patientAgeGroup === selectedAgeGroup)
        .map((d) => calculateDose(d, weightInKg))
    : []

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h2 className="text-2xl font-bold text-gray-900 flex items-center">
          <Scale className="w-8 h-8 mr-2 text-red-600" />
          Dosing Calculator
        </h2>
        <p className="text-gray-600 mt-1">Weight-based medication dosing calculator</p>
      </div>

      {/* Weight Input */}
      <div className="bg-white rounded-lg border border-gray-200 p-6">
        <h3 className="font-semibold text-gray-900 mb-4">Patient Weight</h3>
        <div className="flex items-center space-x-4">
          <input
            type="number"
            value={weightInput}
            onChange={(e) => handleWeightChange(e.target.value)}
            className="flex-1 px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent outline-none"
            placeholder="Enter weight"
            step="0.1"
          />
          <button
            onClick={handleUnitToggle}
            className="px-6 py-3 bg-red-600 text-white rounded-lg font-semibold hover:bg-red-700 transition"
          >
            {weightUnit}
          </button>
        </div>
        <div className="mt-4 text-sm text-gray-600 space-y-1">
          <p>Weight: {weightInKg.toFixed(1)} kg</p>
          <p>Weight: {(weightInKg * 2.20462).toFixed(1)} lbs</p>
        </div>
      </div>

      {/* Age Group Presets */}
      <div className="bg-white rounded-lg border border-gray-200 p-6">
        <h3 className="font-semibold text-gray-900 mb-4">Age Group Presets</h3>
        <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
          {Object.values(AgeGroup).map((group) => (
            <button
              key={group}
              onClick={() => applyPreset(group)}
              className={`px-4 py-3 rounded-lg font-medium transition ${
                selectedAgeGroup === group
                  ? 'bg-red-600 text-white'
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              {group}
            </button>
          ))}
        </div>
      </div>

      {/* Medication Selection */}
      <div className="bg-white rounded-lg border border-gray-200 p-6">
        <h3 className="font-semibold text-gray-900 mb-4">Select Medication</h3>
        <select
          value={selectedMedication?.id || ''}
          onChange={(e) => {
            const med = medications.find((m) => m.id === e.target.value)
            setSelectedMedication(med || null)
          }}
          className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent outline-none"
        >
          <option value="">Select a medication...</option>
          {medications.map((med) => (
            <option key={med.id} value={med.id}>
              {med.name} ({med.genericName})
            </option>
          ))}
        </select>
      </div>

      {/* Calculated Doses */}
      {selectedMedication && (
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <h3 className="font-semibold text-gray-900 mb-4">Calculated Doses for {selectedMedication.name}</h3>
          {doses.length > 0 ? (
            <div className="space-y-4">
              {doses.map((dose) => (
                <div key={dose.id} className="bg-blue-50 rounded-lg p-4">
                  <div className="flex items-start justify-between mb-2">
                    <div className="text-2xl font-bold text-blue-900">
                      {dose.dose.toFixed(2)} {dose.unit}
                    </div>
                    {dose.isMaxDoseReached && (
                      <span className="bg-red-600 text-white text-xs font-bold px-2 py-1 rounded">MAX</span>
                    )}
                  </div>
                  <p className="text-sm text-blue-800 mb-2">{dose.instructions}</p>
                  {dose.maxDose && (
                    <p className="text-xs text-blue-600">
                      Maximum dose: {dose.maxDose} {dose.unit}
                    </p>
                  )}
                  {dose.isMaxDoseReached && (
                    <div className="mt-2 flex items-start space-x-2 text-orange-700">
                      <AlertTriangle className="w-4 h-4 mt-0.5 flex-shrink-0" />
                      <p className="text-xs">Maximum dose reached</p>
                    </div>
                  )}
                </div>
              ))}
            </div>
          ) : (
            <p className="text-gray-500 text-center py-4">No dosing available for selected age group</p>
          )}
        </div>
      )}
    </div>
  )
}

export default DosingCalculatorPage
