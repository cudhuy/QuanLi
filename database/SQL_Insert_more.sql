SELECT
    setval (
        pg_get_serial_sequence ('order_items', 'id'),
        (
            SELECT
                COALESCE(MAX(id), 0)
            FROM
                order_items
        )
    );