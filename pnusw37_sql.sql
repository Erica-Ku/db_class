DELIMITER $$ 
CREATE PROCEDURE InsertUser (
    uid VARCHAR(20),
    uname VARCHAR(50),
    email VARCHAR(50)
) 
BEGIN 
	INSERT INTO user (uid, uname, email)
    VALUES (uid, uname, email) ;
END ;
$$ 
DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE SearchUser (
    uid VARCHAR(20)
    )
BEGIN
    SELECT * FROM user
    WHERE uid = uid ;
END ;
$$ 
DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE UpdateUser (
    uid VARCHAR(20),
    uname VARCHAR(50),
    email VARCHAR(50)
    )
BEGIN
    UPDATE user SET
    uname = uname,
    email = email
    WHERE uid = uid ;
END ;
$$ 
DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE DeleteUser (
    uid VARCHAR(20)
)
BEGIN
    INSERT INTO deluser (uid, uname, email, wdate)
    SELECT uid, uname, email, GETDATE()
    FROM user
    WHERE uid = uid;
    DELETE FROM user WHERE uid = uid;
END ;
$$ 
DELIMITER ;

CREATE TRIGGER user_delete_trigger
AFTER DELETE ON user
FOR EACH ROW
INSERT INTO deluser (uid, uname, email, wdate)
VALUES (OLD.uid, OLD.uname, OLD.email, NOW());