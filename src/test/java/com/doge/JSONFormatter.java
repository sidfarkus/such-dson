package com.doge;

import java.util.List;

import com.doge.SuchDSONParser.*;
import com.doge.SuchDSONLexer;
import com.doge.SuchDSONBaseListener;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.misc.NotNull;

public class JSONFormatter extends SuchDSONBaseListener {
    private final StringBuilder builder = new StringBuilder();

    @Override
    public void enterObject(@NotNull SuchDSONParser.ObjectContext ctx) {
        builder.append("{ ");
        if (ctx.members() != null) {
            List<PairContext> pairs = ctx.members().pair();
            for (PairContext pair : pairs) {
                builder.append(pair.STRING().getText() + ": ");
                appendValueText(pair.value());
                if (pair != pairs.get(pairs.size() - 1)) {
                    builder.append(",\n");
                }
            }
        }
    }

    @Override
    public void exitObject(@NotNull SuchDSONParser.ObjectContext ctx) {
        builder.append(" }");
    }

    @Override
    public String toString() {
        return builder.toString();
    }

    private void appendValueText(ValueContext value) {
        if (value.array() != null) {
            builder.append("[");
            if (value.array().elements() != null) {
                List<ValueContext> vals = value.array().elements().value();
                for (ValueContext val : vals) {
                    appendValueText(val);
                    if (val != vals.get(vals.size() - 1)) {
                        builder.append(", ");
                    }
                }
            }
            builder.append("]");
        } else if (value.object() == null) {
            builder.append(value.getText());
        }
    }
}