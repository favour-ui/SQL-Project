
SELECT * FROM dimcapbatch;
SELECT * FROM dimdate;
SELECT * FROM dimjuicebatch;
SELECT * FROM dimmachine;
SELECT * FROM dimnozzle;
SELECT * FROM dimoperator;
SELECT * FROM dimsupplier;
SELECT * FROM factproductionevent;



SELECT MAX(Datekey),MIN(Datekey) FROM factproductionevent
;



SELECT 
    c.SupplierSK,
    f.DateKey,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimmachine m ON c.CapBatchSK = m.MachineSK
JOIN dimnozzle n ON m.MachineSK = n.NozzleSK
WHERE f.DateKey BETWEEN '2025-02-10' AND '2025-07-15'
GROUP BY c.SupplierSK, f.DateKey
ORDER BY total_CAPS DESC;



SELECT 
    c.SupplierSK,
    c.DateReceived,f.Datekey,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimmachine m ON c.CapBatchSK = m.MachineSK
JOIN dimnozzle n ON m.MachineSK = n.NozzleSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY c.SupplierSK, c.DateReceived,f.Datekey
ORDER BY total_CAPS DESC;




SELECT 
    f.DateKey,
    c.CapMaterial,
    c.CapType,
    s.SupplierName,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0 / COUNT(c.CapBatchID_Natural) AS LeakyCap_percent,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) AS Amount_lost
FROM factproductionevent f
JOIN dimcapbatch c ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
AND c.CapType = '28mm PCO1881 HDPE' AND s.SupplierName = 'Anambra Glass & PET'
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName
ORDER BY f.DateKey;


-- 1 WEEK BEFORE THE DEFECT DATE 
SELECT 
    f.DateKey,
    c.CapMaterial,
    c.CapType,
    s.SupplierName,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(c.CapBatchID_Natural), 0) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s 
    ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-06-25' AND '2025-07-01'   -- 1 week BEFORE the defect days only
AND c.CapType = '28mm PCO1881 HDPE' AND s.SupplierName = 'Anambra Glass & PET'
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName
ORDER BY f.DateKey, LeakyCap_percent DESC;



-- 1 WEEK AFTER THE DEFECT
SELECT 
    f.DateKey,
    c.CapMaterial,
    c.CapType,
    s.SupplierName,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0 / COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s 
    ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-07-04' AND '2025-07-11'   -- 1 week AFTER the defect days
AND c.CapType = '28mm PCO1881 HDPE' AND s.SupplierName = 'Anambra Glass & PET'
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName
ORDER BY f.DateKey, LeakyCap_percent DESC;



SELECT c.CapMaterial, c.CapType, MIN(c.CostPerCap_NGN) AS min_cost, MAX(c.CostPerCap_NGN) AS max_cost
FROM dimcapbatch c
GROUP BY c.CapMaterial, c.CapType;

