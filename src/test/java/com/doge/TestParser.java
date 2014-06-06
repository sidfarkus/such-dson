package com.doge;

import java.util.ArrayList;

import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.BailErrorStrategy;
import org.antlr.v4.runtime.CommonToken;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

import org.junit.Test;
import org.junit.Assert;
import org.junit.Ignore;

import com.doge.SuchDSONParser.*;

public class TestParser {

    @Test
    public void testParsing()  throws Exception {
        ObjectContext tree = getParser("such \"foo\" is so \"bar\" next \"baz\" next \"fizzbuzz\" many wow").object();
        final JSONFormatter formatter = new JSONFormatter();
        ParseTreeWalker.DEFAULT.walk(formatter, tree);
        System.out.println(formatter.toString());
    }

    private SuchDSONParser getParser(String dson) {
        final SuchDSONLexer lexer = new SuchDSONLexer(new ANTLRInputStream(dson));
        final SuchDSONParser parser = new SuchDSONParser(new CommonTokenStream(lexer));
        parser.setErrorHandler(new BailErrorStrategy());
        return parser;
    }
}
