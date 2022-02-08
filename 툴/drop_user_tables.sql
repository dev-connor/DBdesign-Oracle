SELECT  'DROP TABLE ' || object_name || ' CASCADE CONSTRAINTS;'
FROM    user_objects
WHERE   object_type = 'TABLE';