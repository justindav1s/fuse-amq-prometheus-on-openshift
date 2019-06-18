/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


//<route id="generate-order-route" streamCache="true">
//        <from id="route-timer" uri="timer:order?period=3000"/>
//        <bean id="route-new-order" method="generateOrder" ref="orderGenerator"/>
//        <setHeader headerName="Exchange.FILE_NAME" id="route-set-order-header">
//        <!-- defining the header containing a simulated file name -->
//        <method method="generateFileName" ref="orderGenerator"/>
//        </setHeader>
//        <log id="route-log-order" message="Generating order ${file:name}"/>
//        <to id="route-to-incoming-orders" uri="amqp:queue:incomingOrders"/>
//        </route>

package sample.camel;

import org.apache.camel.builder.RouteBuilder;
import org.springframework.stereotype.Component;

//@Component
//public class SampleAutowiredAmqRoute extends RouteBuilder {
//
//    @Override
//    public void configure() throws Exception {
//        from("jms:foo")
//            .to("log:sample");
//
//        from("timer:bar")
//            .setBody(constant("Hello from Camel"))
//            .to("jms:foo");
//    }
//
//}
