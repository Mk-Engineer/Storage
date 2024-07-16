/* 导入module.js文件 */
import {g,PI,PI as pi,sum,Person} from './module.js'

console.log(PI)
console.log(pi)
console.log(sum(10,20))
let person = new Person("Jack","10")
person.sayHello()
