import { CertificationLevel, certificationLevelInfo } from '../types'

interface Props {
  level: CertificationLevel
  size?: 'small' | 'normal'
}

const CertificationBadge = ({ level, size = 'normal' }: Props) => {
  const info = certificationLevelInfo[level]
  const sizeClasses = size === 'small' ? 'text-xs px-2 py-1' : 'text-sm px-3 py-1.5'

  return (
    <span
      className={`inline-flex items-center font-semibold rounded-lg text-white ${sizeClasses}`}
      style={{ backgroundColor: info.color }}
    >
      {level}
    </span>
  )
}

export default CertificationBadge
