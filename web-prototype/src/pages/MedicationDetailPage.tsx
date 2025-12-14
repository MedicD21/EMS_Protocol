import { useParams, Link } from 'react-router-dom'
import { useStore } from '../store/useStore'
import CertificationBadge from '../components/CertificationBadge'
import { ArrowLeft } from 'lucide-react'

const MedicationDetailPage = () => {
  const { id } = useParams()
  const medications = useStore((state) => state.medications)
  const med = medications.find((m) => m.id === id)

  if (!med) return <div className="text-center py-12 text-gray-500">Medication not found</div>

  return (
    <div className="space-y-6">
      <div>
        <Link to="/medications" className="inline-flex items-center text-red-600 hover:text-red-700 mb-4">
          <ArrowLeft className="w-4 h-4 mr-1" />
          Back
        </Link>
        <h2 className="text-2xl font-bold text-gray-900">{med.name}</h2>
        <p className="text-gray-600">{med.genericName}</p>
        <div className="flex items-center space-x-2 mt-2">
          <CertificationBadge level={med.certificationLevel} />
          <span className="text-sm px-3 py-1 bg-gray-100 rounded">{med.classification}</span>
        </div>
      </div>

      <div className="bg-white rounded-lg border p-4 space-y-4">
        <div>
          <h3 className="font-semibold mb-2">Mechanism of Action</h3>
          <p className="text-gray-700">{med.mechanismOfAction}</p>
        </div>
        <div>
          <h3 className="font-semibold mb-2">Indications</h3>
          <ul className="list-disc list-inside space-y-1">
            {med.indications.map((ind, i) => (
              <li key={i} className="text-gray-700">{ind}</li>
            ))}
          </ul>
        </div>
        <div>
          <h3 className="font-semibold mb-2 text-red-700">Contraindications</h3>
          <ul className="list-disc list-inside space-y-1">
            {med.contraindications.map((con, i) => (
              <li key={i} className="text-red-600">{con}</li>
            ))}
          </ul>
        </div>
        <div>
          <h3 className="font-semibold mb-2">Dosing</h3>
          {med.dosing.map((dose, i) => (
            <div key={i} className="bg-blue-50 rounded p-3 mb-2">
              <p className="font-medium">{dose.indication} - {dose.patientAgeGroup}</p>
              <p className="text-sm">{dose.amount} {dose.unit} {dose.weightBased && '(weight-based)'}</p>
              <p className="text-xs text-gray-600 mt-1">{dose.instructions}</p>
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}

export default MedicationDetailPage
