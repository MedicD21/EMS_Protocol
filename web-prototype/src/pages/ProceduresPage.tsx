import { Link } from 'react-router-dom'
import { useStore } from '../store/useStore'
import CertificationBadge from '../components/CertificationBadge'
import { ChevronRight } from 'lucide-react'

const ProceduresPage = () => {
  const procedures = useStore((state) => state.procedures)

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-900">Procedures</h2>
        <p className="text-gray-600 mt-1">Step-by-step clinical procedures</p>
      </div>

      <div className="space-y-3">
        {procedures.map((proc) => (
          <Link
            key={proc.id}
            to={`/procedures/${proc.id}`}
            className="block bg-white rounded-lg border border-gray-200 hover:shadow-lg transition-shadow p-4"
          >
            <div className="flex items-center justify-between">
              <div className="flex-1">
                <h3 className="font-semibold text-gray-900">{proc.name}</h3>
                <div className="flex items-center space-x-2 mt-2">
                  <span className="text-xs px-2 py-1 bg-gray-100 text-gray-700 rounded">{proc.category}</span>
                  <CertificationBadge level={proc.certificationLevel} size="small" />
                </div>
              </div>
              <ChevronRight className="w-5 h-5 text-gray-400" />
            </div>
          </Link>
        ))}
      </div>
    </div>
  )
}

export default ProceduresPage
