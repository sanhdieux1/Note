bulk insert ecm_kitydo
from '\\aavn-ws-423\Sharing\import_kitydo_1.csv'
with
(
	CODEPAGE='RAW',
	FIELDTERMINATOR = '~',
	ROWTERMINATOR = '\r\n',
	FORMATFILE = '\\aavn-ws-423\Sharing\documentKind_ecm_kitydo_format.fmt'
);
