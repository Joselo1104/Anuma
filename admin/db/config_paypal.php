<?php
// Configuracion PayPal
// Reemplaza estos valores con tus credenciales de PayPal Developer.

const PAYPAL_MODE = 'sandbox'; // sandbox o live
const PAYPAL_CLIENT_ID = 'ASdvIfuYQg9Szl92FaNEyqzqJE0NaOZZq7MWTa7JXe-On_sgCDxFBmNrwzz2lqyq-UD62oTQKHihtpHy';
const PAYPAL_CLIENT_SECRET = 'EAbjRt0Qu5U3MNTtRB6qZraYVapj2YpeUGKULMKQLMLVzZj8AI2n09aJw5pn_TyDtjw2gPOMkJztNvPC';

function paypal_base_url() {
    return PAYPAL_MODE === 'live'
        ? 'https://api-m.paypal.com'
        : 'https://api-m.sandbox.paypal.com';
}
