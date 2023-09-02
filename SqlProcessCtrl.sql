# 20 流程控制函数

#IF(VALUE,VALUE1,VALUE2)
/* VALUE为TRUE输出VALUE1,VALUE为FALSE输出VALUE2 */
SELECT last_name,salary,IF(salary >= 6000,'High Salary','Low Salary')
FROM employees;

SELECT last_name,commission_pct,IF(commission_pct IS NOT NULL,commission_pct,0) "details",
salary * 12 * (1 + IF(commission_pct IS NOT NULL,commission_pct,0)) "annual_sal"
FROM employees;


#IFNULL(VALUE1,VALUE2)
/* VALUE1为NULL输出VALUE2,否则输出VALUE1 */
SELECT last_name,commission_pct,IFNULL(commission_pct,0) "details"
FROM employees;


#CASE WHEN .. THEN .. WHEN .. THEN .. ELSE .. END
SELECT last_name,salary,CASE WHEN salary >= 15000 THEN 'A'
                             WHEN salary >= 10000 THEN 'B'
                             WHEN salary >= 8000 THEN 'C'
                             ELSE 'D' END "details"
FROM employees;                             

SELECT last_name,salary,CASE WHEN salary >= 15000 THEN 'A'
                             WHEN salary >= 10000 THEN 'B'
                             WHEN salary >= 8000 THEN 'C'
                             END "details"
FROM employees;  


#CASE 表达式 WHEN .. THEN .. WHEN .. THEN .. ELSE .. END
/* 
#练习1
查询部门号为10，20，30的员工信息，若部门号为10，则打印其工资的1.1倍。
                                    20号部门，则打印其工资的1.2倍。
                                    30号部门，则打印其工资的1.3倍
                                    其他部门，则打印其工资的1.4倍。

#练习2
查询部门号为10，20，30的员工信息，若部门号为10，则打印其工资的1.1倍。
                                    20号部门，则打印其工资的1.2倍。
                                    30号部门，则打印其工资的1.3倍。
*/
SELECT employee_id,last_name,department_id,salary,
CASE department_id WHEN 10 THEN salary * 1.1
                   WHEN 20 THEN salary * 1.2
                   WHEN 30 THEN salary * 1.3
                   ELSE salary * 1.4 END "details"
FROM employees;                   

SELECT employee_id,last_name,department_id,salary,
CASE department_id WHEN 10 THEN salary * 1.1
                   WHEN 20 THEN salary * 1.2
                   WHEN 30 THEN salary * 1.3
                   END "details"
FROM employees
WHERE department_id IN(10,20,30);


# 21 加密与解密
/* SELECT PASSWORD('mysql') */ /* 在MySQL8.0中被弃用 */
SELECT MD5('mysql'),SHA('mysql')
FROM DUAL;