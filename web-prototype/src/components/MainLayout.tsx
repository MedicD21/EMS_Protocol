import { Outlet, NavLink } from 'react-router-dom'
import { FileText, Pill, Clipboard, Calculator, Settings } from 'lucide-react'

const MainLayout = () => {
  const navItems = [
    { path: '/protocols', icon: FileText, label: 'Protocols' },
    { path: '/medications', icon: Pill, label: 'Medications' },
    { path: '/procedures', icon: Clipboard, label: 'Procedures' },
    { path: '/dosing', icon: Calculator, label: 'Dosing' },
    { path: '/settings', icon: Settings, label: 'Settings' }
  ]

  return (
    <div className="min-h-screen flex flex-col bg-gray-50">
      {/* Header */}
      <header className="bg-red-600 text-white shadow-lg">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3">
              <div className="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
                <span className="text-red-600 text-2xl font-bold">+</span>
              </div>
              <div>
                <h1 className="text-xl font-bold">EMS Protocol</h1>
                <p className="text-xs text-red-100">Clinical Guidelines & Reference</p>
              </div>
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <div className="flex-1 container mx-auto px-4 py-6 pb-20">
        <Outlet />
      </div>

      {/* Bottom Navigation */}
      <nav className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 shadow-lg z-50">
        <div className="container mx-auto px-2">
          <div className="flex justify-around items-center h-16">
            {navItems.map((item) => (
              <NavLink
                key={item.path}
                to={item.path}
                className={({ isActive }) =>
                  `flex flex-col items-center justify-center flex-1 h-full space-y-1 transition-colors ${
                    isActive ? 'text-red-600' : 'text-gray-600 hover:text-gray-900'
                  }`
                }
              >
                <item.icon className="w-6 h-6" />
                <span className="text-xs font-medium">{item.label}</span>
              </NavLink>
            ))}
          </div>
        </div>
      </nav>
    </div>
  )
}

export default MainLayout
