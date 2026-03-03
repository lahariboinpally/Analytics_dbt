with 

source as (

    select * from {{ source('ecom', 'raw_orders') }}

),

renamed as (

    select
        -- Primary Key
        id as order_id,

        -- Foreign Keys
        store_id as location_id,
        customer as customer_id,
        
        -- Numerics
        coalesce(subtotal::number, 0) as subtotal_cents,
        coalesce(tax_paid::number, 0) as tax_paid_cents,
        coalesce(order_total::number, 0) as order_total_cents,
        {{ cents_to_dollars('subtotal') }} as subtotal,
        {{ cents_to_dollars('tax_paid') }} as tax_paid,
        {{ cents_to_dollars('order_total') }} as order_total,

        -- Timestamps & Dates
        to_timestamp_ntz(ordered_at) as ordered_at,

    from source

)

select * from renamed