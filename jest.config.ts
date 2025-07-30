import type {Config} from 'jest'

const config: Config = {
    clearMocks: true,
    collectCoverage: true,
    coverageDirectory: 'coverage',
    coverageProvider: 'v8',
    moduleNameMapper: {
        '^@riyo/(.*)$': '<rootDir>/src/$1',
    },
    preset: 'ts-jest',
    testEnvironment: 'node',
    transform: {
        '^.+\\.ts$': 'ts-jest',
    },
}

export default config
