package com.chiguru.pm.crm.util;

import java.beans.PropertyEditorSupport;

import java.util.List;


public class ListSizeEditor<T> extends PropertyEditorSupport {
    public static final int DEFAULT_MAX_SIZE = 1000;
    private final Class<T> element;
    private final int maxSize;

    public ListSizeEditor(Class<T> element) {
        this(element, DEFAULT_MAX_SIZE);
    }

    public ListSizeEditor(Class<T> element, int maxSize) {
        this.element = element;
        this.maxSize = maxSize;
    }

    public String getAsText() {
        return String.valueOf(getListValue().size());
    }

    public void setAsText(String text) throws IllegalArgumentException {
        List<T> value = getListValue();
        int size = Integer.parseInt(text);

        if (size > maxSize) {
            throw new RuntimeException("Maximum size exceeded.");
        }

        while (value.size() < size) {
            value.add(newInstance());
        }

        while (value.size() > size) {
            value.remove(value.size() - 1);
        }

        setValue(value);
    }

    private List<T> getListValue() {
        List<T> value = (List<T>) getValue();

        if (value == null) {
            throw new RuntimeException(
                "This editor requires a not null value to be set, " +
                "typically this could be an empty mutable list instead of null.");
        }

        return value;
    }

    private T newInstance() {
        try {
            return element.newInstance();
        } catch (InstantiationException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }
    }
}
