package com.omen.test;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.omen.pojo.Dog;
import com.omen.pojo.Person;
import org.testng.annotations.Test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 0xhekt
 * @date 2024/5/16 - 16:23
 */
public class TestJson {
    @Test
    public void testWriteJson() throws JsonProcessingException {
        //实例化Person对象，将Person对象转换为JSON串
        Dog dog = new Dog("小黄");
        Person person = new Person("张三",10,dog);
        //将Person对象转换成一个JSON字符串 Gson / Jackson / Fastjson
        ObjectMapper objectMapper = new ObjectMapper();
        String personStr = objectMapper.writeValueAsString(person);
        System.out.println(personStr);
    }

    @Test
    public void testReadJson() throws JsonProcessingException {
        String personStr = "{\"name\":\"李四\",\"age\":18,\"dog\":{\"name\":\"小花\"}}";
        ObjectMapper objectMapper = new ObjectMapper();
        Person person = objectMapper.readValue(personStr, Person.class);
        System.out.print(person);
    }
    //Map和JSON之间的转换
    @Test
    public void testMapToJson() throws JsonProcessingException {
        Map data = new HashMap();
        data.put("a","valuea");
        data.put("b","valueb");

        ObjectMapper objectMapper = new ObjectMapper();
        String s = objectMapper.writeValueAsString(data);
        System.out.println(s);
    }

    //List / Array和JSON之间的转换
    @Test
    public void testListToJson() throws JsonProcessingException {
//        List data = new ArrayList();
//        data.add("a");
//        data.add("b");
//        data.add("c");

//        String[] data = {"a","b","c"};

        Dog dog = new Dog("小花");
        Person person = new Person("李四",18,dog);
        List data = new ArrayList();
        data.add(person);

        ObjectMapper objectMapper = new ObjectMapper();
        String s = objectMapper.writeValueAsString(data);
        System.out.println(s);
    }
}

