import { useState, useMemo } from 'react'
import { Link } from 'react-router-dom'
import { useStore } from '../store/useStore'
import { ProtocolCategory, certificationLevelInfo } from '../types'
import CertificationBadge from '../components/CertificationBadge'
import { Search, ChevronRight, Plus } from 'lucide-react'

const ProtocolsPage = () => {
  const protocols = useStore((state) => state.protocols)
  const currentUser = useStore((state) => state.currentUser)
  const [selectedCategory, setSelectedCategory] = useState<ProtocolCategory | null>(null)
  const [searchQuery, setSearchQuery] = useState('')

  const filteredProtocols = useMemo(() => {
    return protocols.filter((protocol) => {
      const matchesCategory = !selectedCategory || protocol.category === selectedCategory
      const matchesSearch =
        !searchQuery ||
        protocol.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        protocol.detailedDescription.toLowerCase().includes(searchQuery.toLowerCase())

      const matchesCert = currentUser
        ? certificationLevelInfo[protocol.certificationLevel].skillLevel <=
          certificationLevelInfo[currentUser.certificationLevel].skillLevel
        : true

      return matchesCategory && matchesSearch && matchesCert
    })
  }, [protocols, selectedCategory, searchQuery, currentUser])

  const categories = Object.values(ProtocolCategory)

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h2 className="text-2xl font-bold text-gray-900">Protocols</h2>
        <p className="text-gray-600 mt-1">Clinical guidelines and treatment protocols</p>
      </div>

      {/* Search */}
      <div className="relative">
        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5" />
        <input
          type="text"
          placeholder="Search protocols..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent outline-none"
        />
      </div>

      {/* Category Filter */}
      <div className="flex overflow-x-auto space-x-2 pb-2 hide-scrollbar">
        <button
          onClick={() => setSelectedCategory(null)}
          className={`px-4 py-2 rounded-lg font-medium whitespace-nowrap transition ${
            selectedCategory === null ? 'bg-red-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
          }`}
        >
          All
        </button>
        {categories.map((category) => (
          <button
            key={category}
            onClick={() => setSelectedCategory(category)}
            className={`px-4 py-2 rounded-lg font-medium whitespace-nowrap transition ${
              selectedCategory === category ? 'bg-red-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
            }`}
          >
            {category}
          </button>
        ))}
      </div>

      {/* Protocols List */}
      <div className="space-y-3">
        {filteredProtocols.map((protocol) => (
          <Link
            key={protocol.id}
            to={`/protocols/${protocol.id}`}
            className="block bg-white rounded-lg border border-gray-200 hover:shadow-lg transition-shadow p-4"
          >
            <div className="flex items-start space-x-4">
              <div
                className="w-1.5 h-full rounded-full flex-shrink-0"
                style={{ backgroundColor: certificationLevelInfo[protocol.certificationLevel].color }}
              />
              <div className="flex-1 min-w-0">
                <h3 className="font-semibold text-gray-900 mb-2">{protocol.title}</h3>
                <div className="flex items-center space-x-2 mb-2">
                  <span className="text-xs px-2 py-1 bg-gray-100 text-gray-700 rounded">{protocol.category}</span>
                  <CertificationBadge level={protocol.certificationLevel} size="small" />
                </div>
                <p className="text-sm text-gray-600 line-clamp-2">{protocol.detailedDescription}</p>
              </div>
              <ChevronRight className="w-5 h-5 text-gray-400 flex-shrink-0" />
            </div>
          </Link>
        ))}
      </div>

      {filteredProtocols.length === 0 && (
        <div className="text-center py-12 text-gray-500">
          <p>No protocols found matching your criteria.</p>
        </div>
      )}
    </div>
  )
}

export default ProtocolsPage
