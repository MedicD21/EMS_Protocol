import { useParams, Link } from 'react-router-dom'
import { useStore } from '../store/useStore'
import CertificationBadge from '../components/CertificationBadge'
import { ArrowLeft, AlertCircle } from 'lucide-react'

const ProcedureDetailPage = () => {
  const { id } = useParams()
  const procedures = useStore((state) => state.procedures)
  const proc = procedures.find((p) => p.id === id)

  if (!proc) return <div className="text-center py-12 text-gray-500">Procedure not found</div>

  return (
    <div className="space-y-6">
      <div>
        <Link to="/procedures" className="inline-flex items-center text-red-600 hover:text-red-700 mb-4">
          <ArrowLeft className="w-4 h-4 mr-1" />
          Back
        </Link>
        <h2 className="text-2xl font-bold text-gray-900">{proc.name}</h2>
        <div className="flex items-center space-x-2 mt-2">
          <CertificationBadge level={proc.certificationLevel} />
          <span className="text-sm px-3 py-1 bg-gray-100 rounded">{proc.category}</span>
        </div>
      </div>

      <div className="bg-white rounded-lg border p-4 space-y-4">
        <div>
          <h3 className="font-semibold mb-2">Indications</h3>
          <ul className="list-disc list-inside space-y-1">
            {proc.indications.map((ind, i) => (
              <li key={i} className="text-gray-700">{ind}</li>
            ))}
          </ul>
        </div>

        <div>
          <h3 className="font-semibold mb-2">Equipment Required</h3>
          <ul className="list-disc list-inside space-y-1">
            {proc.equipment.map((eq, i) => (
              <li key={i} className="text-gray-700">{eq}</li>
            ))}
          </ul>
        </div>

        <div>
          <h3 className="font-semibold mb-4">Procedure Steps</h3>
          {proc.steps.map((step) => (
            <div key={step.id} className={`flex space-x-4 mb-4 ${step.criticalPoint ? 'bg-red-50 p-3 rounded' : ''}`}>
              <div className="flex-shrink-0 w-8 h-8 rounded-full bg-red-600 text-white flex items-center justify-center font-bold">
                {step.order}
              </div>
              <div className="flex-1">
                <p className="text-gray-900">{step.instruction}</p>
                {step.criticalPoint && (
                  <div className="flex items-center text-red-600 text-sm mt-1">
                    <AlertCircle className="w-4 h-4 mr-1" />
                    <span className="font-semibold">Critical Step</span>
                  </div>
                )}
              </div>
            </div>
          ))}
        </div>

        {proc.complications.length > 0 && (
          <div>
            <h3 className="font-semibold mb-2 text-orange-700">Potential Complications</h3>
            <ul className="list-disc list-inside space-y-1">
              {proc.complications.map((comp, i) => (
                <li key={i} className="text-orange-600">{comp}</li>
              ))}
            </ul>
          </div>
        )}
      </div>
    </div>
  )
}

export default ProcedureDetailPage
