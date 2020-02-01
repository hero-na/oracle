begin
for i in 1..10000 loop
  insert into extend_test_tb values(i,'CHOI');
end loop;
commit;
end;
/
