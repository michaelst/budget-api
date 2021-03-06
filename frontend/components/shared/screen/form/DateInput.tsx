import React, { Dispatch, SetStateAction, useState } from 'react'
import { Text, View } from 'react-native'
import DateTimePickerModal from "react-native-modal-datetime-picker"
import AppStyles from 'constants/AppStyles'
import { TouchableWithoutFeedback } from 'react-native-gesture-handler'
import { DateTime } from 'luxon'

export type DateField = {
  title: string,
  value: Date,
  setValue: Dispatch<SetStateAction<Date>>,
}

export default function DateInput({ title, value, setValue }: DateField) {
  const { styles } = AppStyles()

  const [modalVisible, setModalVisible] = useState(false)

  return (
    <View style={styles.row}>
      <View style={{ flex: 1 }}>
        <Text style={styles.text}>
          {title}
        </Text>
      </View>

      <View style={{ width: '70%' }}>
        <TouchableWithoutFeedback onPress={() => setModalVisible(true)}>
          <Text style={styles.formInputText}>
            {DateTime.fromJSDate(value).toLocaleString(DateTime.DATE_MED)}
          </Text>
        </TouchableWithoutFeedback>
        <DateTimePickerModal
          isVisible={modalVisible}
          mode="date"
          date={value}
          onConfirm={date => {
            setValue(date)
            setModalVisible(false)
          }}
          onCancel={() => setModalVisible(false)}
        />
      </View>
    </View>
  )
}