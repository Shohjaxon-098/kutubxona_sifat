enum GenderType { male, female }

enum VerificationType { passport, idCard }

String genderTypeToString(GenderType gender) =>
    gender == GenderType.male ? "male" : "female";

String verificationTypeToString(VerificationType type) =>
    type == VerificationType.passport ? "passport" : "id_card";
