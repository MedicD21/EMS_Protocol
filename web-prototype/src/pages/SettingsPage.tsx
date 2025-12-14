import { useStore } from '../store/useStore'
import { LogOut, User, Award, MapPin, Building } from 'lucide-react'

const SettingsPage = () => {
  const { currentUser, logout } = useStore()

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-gray-900">Settings</h2>
        <p className="text-gray-600 mt-1">Account and preferences</p>
      </div>

      {currentUser && (
        <>
          <div className="bg-white rounded-lg border border-gray-200 p-6">
            <h3 className="font-semibold text-gray-900 mb-4">Profile</h3>
            <div className="space-y-3">
              <div className="flex items-center space-x-3 text-gray-700">
                <User className="w-5 h-5" />
                <div>
                  <p className="text-sm text-gray-500">Username</p>
                  <p className="font-medium">{currentUser.username}</p>
                </div>
              </div>
              <div className="flex items-center space-x-3 text-gray-700">
                <Award className="w-5 h-5" />
                <div>
                  <p className="text-sm text-gray-500">Certification</p>
                  <p className="font-medium">{currentUser.certificationLevel}</p>
                </div>
              </div>
              <div className="flex items-center space-x-3 text-gray-700">
                <MapPin className="w-5 h-5" />
                <div>
                  <p className="text-sm text-gray-500">State</p>
                  <p className="font-medium">{currentUser.state}</p>
                </div>
              </div>
              <div className="flex items-center space-x-3 text-gray-700">
                <Building className="w-5 h-5" />
                <div>
                  <p className="text-sm text-gray-500">Agency</p>
                  <p className="font-medium">{currentUser.agency}</p>
                </div>
              </div>
              <div className="flex items-center space-x-3 text-gray-700">
                <div className="w-5 h-5 flex items-center justify-center">
                  <span className="font-bold text-blue-600">R</span>
                </div>
                <div>
                  <p className="text-sm text-gray-500">Role</p>
                  <p className="font-medium">{currentUser.role}</p>
                </div>
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg border border-gray-200 p-6">
            <h3 className="font-semibold text-gray-900 mb-4">About</h3>
            <div className="space-y-2 text-sm text-gray-600">
              <p>Version: 1.0.0</p>
              <p>Guidelines: National Model EMS Clinical Guidelines</p>
              <p>Last Updated: {new Date().toLocaleDateString()}</p>
            </div>
          </div>

          <button
            onClick={logout}
            className="w-full bg-red-600 text-white py-3 px-4 rounded-lg font-semibold hover:bg-red-700 transition-colors flex items-center justify-center space-x-2"
          >
            <LogOut className="w-5 h-5" />
            <span>Logout</span>
          </button>
        </>
      )}
    </div>
  )
}

export default SettingsPage
