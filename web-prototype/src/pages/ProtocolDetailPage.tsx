import { useParams, Link } from 'react-router-dom'
import { useStore } from '../store/useStore'
import { certificationLevelInfo, StepType } from '../types'
import CertificationBadge from '../components/CertificationBadge'
import { ArrowLeft, ArrowDown, BookOpen } from 'lucide-react'

const ProtocolDetailPage = () => {
  const { id } = useParams<{ id: string }>()
  const protocols = useStore((state) => state.protocols)
  const protocol = protocols.find((p) => p.id === id)

  if (!protocol) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-500">Protocol not found</p>
        <Link to="/protocols" className="text-red-600 hover:underline mt-4 inline-block">
          Back to Protocols
        </Link>
      </div>
    )
  }

  const stepTypeColors: Record<StepType, string> = {
    [StepType.Assessment]: 'bg-blue-600',
    [StepType.Intervention]: 'bg-green-600',
    [StepType.Medication]: 'bg-purple-600',
    [StepType.Decision]: 'bg-yellow-600',
    [StepType.Transport]: 'bg-orange-600',
    [StepType.Documentation]: 'bg-gray-600'
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <Link to="/protocols" className="inline-flex items-center text-red-600 hover:text-red-700 mb-4">
          <ArrowLeft className="w-4 h-4 mr-1" />
          Back to Protocols
        </Link>
        <h2 className="text-2xl font-bold text-gray-900">{protocol.title}</h2>
        <div className="flex items-center space-x-2 mt-2">
          <CertificationBadge level={protocol.certificationLevel} />
          <span className="text-sm px-3 py-1 bg-gray-100 text-gray-700 rounded">{protocol.category}</span>
        </div>
        <p className="text-sm text-gray-500 mt-2">
          Last updated: {new Date(protocol.lastUpdated).toLocaleDateString()} • Version {protocol.version}
        </p>
      </div>

      {/* Description */}
      <div className="bg-white rounded-lg border border-gray-200 p-4">
        <h3 className="font-semibold text-gray-900 mb-2">Description</h3>
        <p className="text-gray-700">{protocol.detailedDescription}</p>
      </div>

      {/* Flowchart */}
      <div className="bg-white rounded-lg border border-gray-200 p-4">
        <h3 className="font-semibold text-gray-900 mb-4 flex items-center">
          <BookOpen className="w-5 h-5 mr-2" />
          Protocol Flowchart
        </h3>
        <div className="space-y-4">
          {protocol.flowchartSteps
            .sort((a, b) => a.order - b.order)
            .map((step, index) => (
              <div key={step.id}>
                <div
                  className="rounded-lg p-4 border-2"
                  style={{
                    borderColor: certificationLevelInfo[step.certificationLevel].color,
                    backgroundColor: `${certificationLevelInfo[step.certificationLevel].color}08`
                  }}
                >
                  <div className="flex items-start justify-between mb-2">
                    <span
                      className={`text-xs font-semibold text-white px-2 py-1 rounded ${
                        stepTypeColors[step.stepType]
                      }`}
                    >
                      {step.stepType}
                    </span>
                    <CertificationBadge level={step.certificationLevel} size="small" />
                  </div>
                  <p className="text-gray-900">{step.content}</p>
                  {step.isConditional && step.conditions.length > 0 && (
                    <div className="mt-3 space-y-1">
                      {step.conditions.map((condition, idx) => (
                        <div key={idx} className="flex items-center text-sm text-gray-600">
                          <span className="mr-2">→</span>
                          <span className="italic">If {condition.condition}</span>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
                {index < protocol.flowchartSteps.length - 1 && (
                  <div className="flex justify-center my-2">
                    <ArrowDown className="w-6 h-6 text-gray-400" />
                  </div>
                )}
              </div>
            ))}
        </div>
      </div>

      {/* Educational Points */}
      {protocol.educationalPoints.length > 0 && (
        <div className="bg-white rounded-lg border border-gray-200 p-4">
          <h3 className="font-semibold text-gray-900 mb-4">Educational Points</h3>
          <div className="space-y-4">
            {protocol.educationalPoints.map((point) => (
              <div key={point.id} className="bg-blue-50 rounded-lg p-4">
                <h4 className="font-semibold text-blue-900 mb-2">{point.title}</h4>
                <p className="text-blue-800 text-sm mb-2">{point.content}</p>
                {point.references.length > 0 && (
                  <div className="text-xs text-blue-600">
                    <span className="font-semibold">References:</span> {point.references.join(', ')}
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}

export default ProtocolDetailPage
