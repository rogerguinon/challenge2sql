CREATE TABLE fx_from_usd (
    date DATE,
    eur FLOAT,
    jpy FLOAT,
    gbn FLOAT,
    czk FLOAT,
    dkk FLOAT,
    gbp FLOAT,
    huf FLOAT,
    pln FLOAT,
    ron FLOAT,
    sek FLOAT,
    chf FLOAT,
    isk FLOAT,
    nok FLOAT,
    hrk FLOAT,
    rub FLOAT,
    trl FLOAT,
    try FLOAT,
    aud FLOAT,
    brl FLOAT,
    cad FLOAT,
    cny FLOAT,
    hkd FLOAT,
    idr FLOAT,
    ils FLOAT,
    inr FLOAT,
    krw FLOAT,
    mxn FLOAT,
    myr FLOAT,
    nzd FLOAT,
    php FLOAT,
    sgd FLOAT,
    thb FLOAT,
    zar FLOAT
);

CREATE TABLE fx_to_usd (
    date DATE,
    eur FLOAT,
    jpy FLOAT,
    gbn FLOAT,
    czk FLOAT,
    dkk FLOAT,
    gbp FLOAT,
    huf FLOAT,
    pln FLOAT,
    ron FLOAT,
    sek FLOAT,
    chf FLOAT,
    isk FLOAT,
    nok FLOAT,
    hrk FLOAT,
    rub FLOAT,
    trl FLOAT,
    try FLOAT,
    aud FLOAT,
    brl FLOAT,
    cad FLOAT,
    cny FLOAT,
    hkd FLOAT,
    idr FLOAT,
    ils FLOAT,
    inr FLOAT,
    krw FLOAT,
    mxn FLOAT,
    myr FLOAT,
    nzd FLOAT,
    php FLOAT,
    sgd FLOAT,
    thb FLOAT,
    zar FLOAT
);

LOAD DATA LOCAL INFILE 'C:/Users/roger/Downloads/FX_USD_conversions/FX_from_USD.csv' INTO TABLE fx_from_usd
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 2 ROWS
(date, eur, jpy, gbn, czk, dkk, gbp, huf, pln, ron, sek, chf, isk, nok, hrk, rub, trl, try, aud, brl, cad, cny, hkd, idr, ils, inr, krw, mxn, myr, nzd, php, sgd, thb, zar);

LOAD DATA LOCAL INFILE 'C:/Users/roger/Downloads/FX_USD_conversions/FX_to_USD.csv' INTO TABLE fx_to_usd
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 2 ROWS
(date, eur, jpy, gbn, czk, dkk, gbp, huf, pln, ron, sek, chf, isk, nok, hrk, rub, trl, try, aud, brl, cad, cny, hkd, idr, ils, inr, krw, mxn, myr, nzd, php, sgd, thb, zar);