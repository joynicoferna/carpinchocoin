// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef CARPINCHO_QT_CARPINCHOADDRESSVALIDATOR_H
#define CARPINCHO_QT_CARPINCHOADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class CARPINCHOAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CARPINCHOAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** CARPINCHO address widget validator, checks for a valid carpincho address.
 */
class CARPINCHOAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CARPINCHOAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // CARPINCHO_QT_CARPINCHOADDRESSVALIDATOR_H
