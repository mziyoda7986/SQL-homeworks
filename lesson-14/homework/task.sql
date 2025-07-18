DECLARE @tr VARCHAR(MAX);

;WITH IndexInfo AS (
    SELECT
        QUOTENAME(SCHEMA_NAME(t.schema_id)) + '.' + QUOTENAME(t.name) AS TableName,
        i.name AS IndexName,
        i.type_desc AS IndexType,
        STUFF((
            SELECT ',' + QUOTENAME(c.name)
            FROM sys.index_columns ic
            INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
            WHERE ic.object_id = i.object_id AND ic.index_id = i.index_id
            ORDER BY ic.key_ordinal
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS IndexedColumnsType
    FROM sys.indexes i
    INNER JOIN sys.objects t ON i.object_id = t.object_id
    --WHERE t.type = 'U' -- user tables
    --AND i.type > 0   -- ignore heaps
)
SELECT @tr = CAST((
    SELECT 
        TableName AS 'td', '', 
        IndexName AS 'td', '',
        IndexType AS 'td', '',
        IndexedColumnsType AS 'td'
    FROM IndexInfo
    FOR XML PATH('tr')
) AS VARCHAR(MAX));


DECLARE @html_body VARCHAR(MAX) = '
    <style>
        #index_table {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
        }
        #index_table td, #index_table th {
          border: 1px solid #ddd;
          padding: 8px;
        }
        #index_table tr:nth-child(even){background-color: #f2f2f2;}
        #index_table tr:hover {background-color: #ddd;}
        #index_table th {
          padding-top: 12px;
          padding-bottom: 12px;
          text-align: left;
          background-color: #04AA6D;
          color: white;
        }
    </style>
    <h2>SQL Server Index Metadata Report</h2>
    <table id="index_table">
        <tr>
            <th>Table Name</th>
            <th>Index Name</th>
            <th>Index Type</th>
            <th>Indexed Columns</th>
        </tr>' + @tr + '
    </table>
';

select @tr

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'GmailProfile',
    @recipients = 'mamatxonovaziyoda7986@gmail.com',
    @subject = 'SQL Server Index Metadata Report',
    @body = @html_body,
    @body_format = 'HTML';

