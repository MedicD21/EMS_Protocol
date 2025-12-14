import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import { useStore } from './store/useStore'
import LoginPage from './pages/LoginPage'
import MainLayout from './components/MainLayout'
import ProtocolsPage from './pages/ProtocolsPage'
import ProtocolDetailPage from './pages/ProtocolDetailPage'
import PharmacologyPage from './pages/PharmacologyPage'
import MedicationDetailPage from './pages/MedicationDetailPage'
import ProceduresPage from './pages/ProceduresPage'
import ProcedureDetailPage from './pages/ProcedureDetailPage'
import DosingCalculatorPage from './pages/DosingCalculatorPage'
import SettingsPage from './pages/SettingsPage'

function App() {
  const isAuthenticated = useStore((state) => state.isAuthenticated)

  return (
    <BrowserRouter>
      <Routes>
        {!isAuthenticated ? (
          <>
            <Route path="/login" element={<LoginPage />} />
            <Route path="*" element={<Navigate to="/login" replace />} />
          </>
        ) : (
          <Route path="/" element={<MainLayout />}>
            <Route index element={<Navigate to="/protocols" replace />} />
            <Route path="protocols" element={<ProtocolsPage />} />
            <Route path="protocols/:id" element={<ProtocolDetailPage />} />
            <Route path="medications" element={<PharmacologyPage />} />
            <Route path="medications/:id" element={<MedicationDetailPage />} />
            <Route path="procedures" element={<ProceduresPage />} />
            <Route path="procedures/:id" element={<ProcedureDetailPage />} />
            <Route path="dosing" element={<DosingCalculatorPage />} />
            <Route path="settings" element={<SettingsPage />} />
            <Route path="*" element={<Navigate to="/protocols" replace />} />
          </Route>
        )}
      </Routes>
    </BrowserRouter>
  )
}

export default App
