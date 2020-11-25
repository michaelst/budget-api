import React from 'react'
import { createStackNavigator } from '@react-navigation/stack'
import TransactionsScreen from './screens/TransactionsScreen'
import SpendableHeader from 'components/headers/spendable-header/SpendableHeader'
import AppStyles from 'constants/AppStyles'
import TransactionScreen from './screens/TransactionScreen'

export type RootStackParamList = {
  Transactions: undefined,
  Transaction: { transactionId: string },
  'Create Transaction': undefined,
  'Edit Transaction': { transactionId: string }
}

const Stack = createStackNavigator()

export default function Budgets() {
  const { fontSize } = AppStyles()

  const options = {
    headerTitleStyle: { fontSize: fontSize },
    headerBackAllowFontScaling: true,
    headerBackTitleStyle: {
      fontSize: fontSize
    }
  }
  return (
    <Stack.Navigator>
      <Stack.Screen name="Transactions" component={TransactionsScreen} options={{...options, ...{headerTitle: () => <SpendableHeader /> }}} />
      <Stack.Screen name="Transaction" component={TransactionScreen} options={options} />
    </Stack.Navigator>
  )
}