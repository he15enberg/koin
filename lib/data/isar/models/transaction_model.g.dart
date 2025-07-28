// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransactionModelCollection on Isar {
  IsarCollection<TransactionModel> get transactionModels => this.collection();
}

const TransactionModelSchema = CollectionSchema(
  name: r'TransactionModel',
  id: -8282894918172491246,
  properties: {
    r'accountLastFourDigits': PropertySchema(
      id: 0,
      name: r'accountLastFourDigits',
      type: IsarType.string,
    ),
    r'amount': PropertySchema(
      id: 1,
      name: r'amount',
      type: IsarType.double,
    ),
    r'bankCode': PropertySchema(
      id: 2,
      name: r'bankCode',
      type: IsarType.string,
    ),
    r'bankName': PropertySchema(
      id: 3,
      name: r'bankName',
      type: IsarType.string,
    ),
    r'bankPhoto': PropertySchema(
      id: 4,
      name: r'bankPhoto',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 5,
      name: r'category',
      type: IsarType.string,
    ),
    r'dateTime': PropertySchema(
      id: 6,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'merchantName': PropertySchema(
      id: 7,
      name: r'merchantName',
      type: IsarType.string,
    ),
    r'merchantPhoto': PropertySchema(
      id: 8,
      name: r'merchantPhoto',
      type: IsarType.string,
    ),
    r'messageAddress': PropertySchema(
      id: 9,
      name: r'messageAddress',
      type: IsarType.string,
    ),
    r'messageBody': PropertySchema(
      id: 10,
      name: r'messageBody',
      type: IsarType.string,
    ),
    r'referenceNumber': PropertySchema(
      id: 11,
      name: r'referenceNumber',
      type: IsarType.string,
    ),
    r'smsType': PropertySchema(
      id: 12,
      name: r'smsType',
      type: IsarType.byte,
      enumMap: _TransactionModelsmsTypeEnumValueMap,
    )
  },
  estimateSize: _transactionModelEstimateSize,
  serialize: _transactionModelSerialize,
  deserialize: _transactionModelDeserialize,
  deserializeProp: _transactionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _transactionModelGetId,
  getLinks: _transactionModelGetLinks,
  attach: _transactionModelAttach,
  version: '3.1.0+1',
);

int _transactionModelEstimateSize(
  TransactionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.accountLastFourDigits.length * 3;
  bytesCount += 3 + object.bankCode.length * 3;
  bytesCount += 3 + object.bankName.length * 3;
  bytesCount += 3 + object.bankPhoto.length * 3;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.merchantName.length * 3;
  {
    final value = object.merchantPhoto;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.messageAddress.length * 3;
  bytesCount += 3 + object.messageBody.length * 3;
  bytesCount += 3 + object.referenceNumber.length * 3;
  return bytesCount;
}

void _transactionModelSerialize(
  TransactionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountLastFourDigits);
  writer.writeDouble(offsets[1], object.amount);
  writer.writeString(offsets[2], object.bankCode);
  writer.writeString(offsets[3], object.bankName);
  writer.writeString(offsets[4], object.bankPhoto);
  writer.writeString(offsets[5], object.category);
  writer.writeDateTime(offsets[6], object.dateTime);
  writer.writeString(offsets[7], object.merchantName);
  writer.writeString(offsets[8], object.merchantPhoto);
  writer.writeString(offsets[9], object.messageAddress);
  writer.writeString(offsets[10], object.messageBody);
  writer.writeString(offsets[11], object.referenceNumber);
  writer.writeByte(offsets[12], object.smsType.index);
}

TransactionModel _transactionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransactionModel(
    accountLastFourDigits: reader.readString(offsets[0]),
    amount: reader.readDouble(offsets[1]),
    bankCode: reader.readString(offsets[2]),
    bankName: reader.readString(offsets[3]),
    bankPhoto: reader.readString(offsets[4]),
    category: reader.readString(offsets[5]),
    dateTime: reader.readDateTime(offsets[6]),
    merchantName: reader.readString(offsets[7]),
    merchantPhoto: reader.readStringOrNull(offsets[8]),
    messageAddress: reader.readString(offsets[9]),
    messageBody: reader.readString(offsets[10]),
    referenceNumber: reader.readString(offsets[11]),
    smsType: _TransactionModelsmsTypeValueEnumMap[
            reader.readByteOrNull(offsets[12])] ??
        TransactionType.credit,
  );
  object.id = id;
  return object;
}

P _transactionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (_TransactionModelsmsTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          TransactionType.credit) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TransactionModelsmsTypeEnumValueMap = {
  'credit': 0,
  'debit': 1,
  'unknown': 2,
};
const _TransactionModelsmsTypeValueEnumMap = {
  0: TransactionType.credit,
  1: TransactionType.debit,
  2: TransactionType.unknown,
};

Id _transactionModelGetId(TransactionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transactionModelGetLinks(TransactionModel object) {
  return [];
}

void _transactionModelAttach(
    IsarCollection<dynamic> col, Id id, TransactionModel object) {
  object.id = id;
}

extension TransactionModelQueryWhereSort
    on QueryBuilder<TransactionModel, TransactionModel, QWhere> {
  QueryBuilder<TransactionModel, TransactionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransactionModelQueryWhere
    on QueryBuilder<TransactionModel, TransactionModel, QWhereClause> {
  QueryBuilder<TransactionModel, TransactionModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionModelQueryFilter
    on QueryBuilder<TransactionModel, TransactionModel, QFilterCondition> {
  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountLastFourDigits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountLastFourDigits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountLastFourDigits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountLastFourDigits',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountLastFourDigits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountLastFourDigits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountLastFourDigits',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountLastFourDigits',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountLastFourDigits',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      accountLastFourDigitsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountLastFourDigits',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankCode',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankCode',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankPhoto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankPhoto',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankPhoto',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      bankPhotoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankPhoto',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'merchantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'merchantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'merchantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'merchantName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'merchantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'merchantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'merchantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'merchantName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'merchantName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'merchantName',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'merchantPhoto',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'merchantPhoto',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'merchantPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'merchantPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'merchantPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'merchantPhoto',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'merchantPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'merchantPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'merchantPhoto',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'merchantPhoto',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'merchantPhoto',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      merchantPhotoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'merchantPhoto',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageBody',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageBody',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageBody',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageBody',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      messageBodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageBody',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'referenceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'referenceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'referenceNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'referenceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'referenceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'referenceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'referenceNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referenceNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      referenceNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'referenceNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      smsTypeEqualTo(TransactionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'smsType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      smsTypeGreaterThan(
    TransactionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'smsType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      smsTypeLessThan(
    TransactionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'smsType',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>
      smsTypeBetween(
    TransactionType lower,
    TransactionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'smsType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionModelQueryObject
    on QueryBuilder<TransactionModel, TransactionModel, QFilterCondition> {}

extension TransactionModelQueryLinks
    on QueryBuilder<TransactionModel, TransactionModel, QFilterCondition> {}

extension TransactionModelQuerySortBy
    on QueryBuilder<TransactionModel, TransactionModel, QSortBy> {
  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByAccountLastFourDigits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountLastFourDigits', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByAccountLastFourDigitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountLastFourDigits', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByBankCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankCode', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByBankCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankCode', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByBankName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByBankNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByBankPhoto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankPhoto', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByBankPhotoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankPhoto', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByMerchantName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantName', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByMerchantNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantName', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByMerchantPhoto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantPhoto', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByMerchantPhotoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantPhoto', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByMessageAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageAddress', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByMessageAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageAddress', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByMessageBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageBody', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByMessageBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageBody', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByReferenceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceNumber', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortByReferenceNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceNumber', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortBySmsType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smsType', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      sortBySmsTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smsType', Sort.desc);
    });
  }
}

extension TransactionModelQuerySortThenBy
    on QueryBuilder<TransactionModel, TransactionModel, QSortThenBy> {
  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByAccountLastFourDigits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountLastFourDigits', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByAccountLastFourDigitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountLastFourDigits', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByBankCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankCode', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByBankCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankCode', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByBankName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByBankNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankName', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByBankPhoto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankPhoto', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByBankPhotoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankPhoto', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByMerchantName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantName', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByMerchantNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantName', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByMerchantPhoto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantPhoto', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByMerchantPhotoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantPhoto', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByMessageAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageAddress', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByMessageAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageAddress', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByMessageBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageBody', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByMessageBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageBody', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByReferenceNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceNumber', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenByReferenceNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referenceNumber', Sort.desc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenBySmsType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smsType', Sort.asc);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterSortBy>
      thenBySmsTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'smsType', Sort.desc);
    });
  }
}

extension TransactionModelQueryWhereDistinct
    on QueryBuilder<TransactionModel, TransactionModel, QDistinct> {
  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByAccountLastFourDigits({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountLastFourDigits',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByBankCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByBankName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByBankPhoto({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankPhoto', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByMerchantName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'merchantName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByMerchantPhoto({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'merchantPhoto',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByMessageAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByMessageBody({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageBody', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctByReferenceNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'referenceNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionModel, TransactionModel, QDistinct>
      distinctBySmsType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'smsType');
    });
  }
}

extension TransactionModelQueryProperty
    on QueryBuilder<TransactionModel, TransactionModel, QQueryProperty> {
  QueryBuilder<TransactionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransactionModel, String, QQueryOperations>
      accountLastFourDigitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountLastFourDigits');
    });
  }

  QueryBuilder<TransactionModel, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<TransactionModel, String, QQueryOperations> bankCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankCode');
    });
  }

  QueryBuilder<TransactionModel, String, QQueryOperations> bankNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankName');
    });
  }

  QueryBuilder<TransactionModel, String, QQueryOperations> bankPhotoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankPhoto');
    });
  }

  QueryBuilder<TransactionModel, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<TransactionModel, DateTime, QQueryOperations>
      dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<TransactionModel, String, QQueryOperations>
      merchantNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'merchantName');
    });
  }

  QueryBuilder<TransactionModel, String?, QQueryOperations>
      merchantPhotoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'merchantPhoto');
    });
  }

  QueryBuilder<TransactionModel, String, QQueryOperations>
      messageAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageAddress');
    });
  }

  QueryBuilder<TransactionModel, String, QQueryOperations>
      messageBodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageBody');
    });
  }

  QueryBuilder<TransactionModel, String, QQueryOperations>
      referenceNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'referenceNumber');
    });
  }

  QueryBuilder<TransactionModel, TransactionType, QQueryOperations>
      smsTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'smsType');
    });
  }
}
