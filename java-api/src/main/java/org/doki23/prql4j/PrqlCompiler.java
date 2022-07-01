package org.doki23.prql4j;

public class PrqlCompiler {
    public static native String toSql(String query);
    public static native String toJson(String query);

    static {
        System.loadLibrary("prql4j");
    }
}
