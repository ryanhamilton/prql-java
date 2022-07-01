//    Copyright 2022 doki23
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//        http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

use jni::objects::{JClass, JString};
use jni::sys::jstring;
use jni::JNIEnv;

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_org_doki23_prql4j_PrqlCompiler_toSql(
    env: JNIEnv,
    _class: JClass,
    query: JString,
) -> jstring {
    let prql_query: String = env
        .get_string(query)
        .expect("Couldn't get java string!")
        .into();
    let rs_sql_str: String =
        prql_compiler::compile(&prql_query).expect("Couldn't compile query to prql!");
    env.new_string(rs_sql_str)
        .expect("Couldn't create java string!")
        .into_inner()
}

#[no_mangle]
#[allow(non_snake_case)]
pub extern "system" fn Java_org_doki23_prql4j_PrqlCompiler_toJson(
    env: JNIEnv,
    _class: JClass,
    query: JString,
) -> jstring {
    let prql_query: String = env
        .get_string(query)
        .expect("Couldn't get java string!")
        .into();
    let rs_json_str: String =
        prql_compiler::to_json(&prql_query).expect("Couldn't get prql json of query!");
    env.new_string(rs_json_str)
        .expect("Couldn't create java string!")
        .into_inner()
}
