package com.omen.test;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.junit.Test;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

/**
 * @author 0xhekt
 * @date 2024/5/18 - 22:53
 */
public class TestDom4j {
    @Test
    public void testRead() throws DocumentException {
        //读取jdbc.xml配置文件，获得documet对象
        SAXReader saxReader = new SAXReader();
        //通过`类加载器`获得指向`字节码根路径`下的指定文件的输入流
        InputStream resourceAsStream = TestDom4j.class.getClassLoader().getResourceAsStream("jdbc.xml");
        //通过输入流获得配置文件，解析成一个DOM对象
        Document document = saxReader.read(resourceAsStream);
        //从document对象上获取配置文件中的信息
        /**
         * Node 结点
         *      Element   元素结点
         *      Attribute 属性结点
         *      Text      文本结点
         * */
        Element rootElement = document.getRootElement();
        System.out.println(rootElement.getName());
        //获取元素下的子元素
        List<Element> elements = rootElement.elements();
        for(Element e : elements){
            System.out.println("\t"+e.getName());
            //从元素上获取属性
            Attribute idAttribute = e.attribute("id");
            System.out.println("\t\t"+idAttribute.getName()+" = "+idAttribute.getValue());
            //继续读取子元素
            List<Element> eles = e.elements();
            for(Element ele : eles){
                System.out.println("\t\t"+ele.getName()+":"+ele.getText());
            }
        }
    }
}
