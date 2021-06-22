DECLARE
    blob1 BLOB;
    src BFILE:= BFILENAME('MYIMAGES', '2015.JPB');
BEGIN
    --create temp LOBs
    DBMS_LOB.CREATETEMPORARY(blob1, TRUE, DBMS_LOB.SESSION);
    IS_TEMP:= DBMS_LOB.ISTEMPORARY(BLOB1);
    
    IF IS_TEMP = 1 THEN DBMS_OUTPUT.PUT_LINE('BLOB1 is temporary blob');
    ELSIF IS_TEMP =2 THEN DBMS_OUTPUT.PUT_LINE('BLOB1 is NOT temporary blob');
    ELSE DBMS_OUTPUT.PUT_LINE('BLOB1 locator is null');
    END IF;
    
    DBMS_LOB.OPEN(src, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.OPEN(blo1, DBMS_LOB.LOB_READWRITE); --OPENING THE TEMPLORAY
    DBMS_LOB.LoadFromFile(blob1, src, DBMS_LOB.GETLENGTH(src));
    
    dbms_lob.freetemporary(blob1); --free temporary
    DBMS_LOB.CLOSE(src);
    
END;