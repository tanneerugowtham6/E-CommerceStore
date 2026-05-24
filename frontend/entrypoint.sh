#!/bin/sh

echo "=== Replacing API URLs in React bundle ==="

# Replace placeholders with actual env var values in all JS files
find /usr/share/nginx/html/static/js/ -name "*.js" -exec sed -i \
  -e "s|PLACEHOLDER_USER_URL|$REACT_APP_USER_SERVICE_URL|g" \
  -e "s|PLACEHOLDER_PRODUCT_URL|$REACT_APP_PRODUCT_SERVICE_URL|g" \
  -e "s|PLACEHOLDER_CART_URL|$REACT_APP_CART_SERVICE_URL|g" \
  -e "s|PLACEHOLDER_ORDER_URL|$REACT_APP_ORDER_SERVICE_URL|g" \
  {} \;

echo "=== URLs replaced successfully ==="
echo "  User Service    : $REACT_APP_USER_SERVICE_URL"
echo "  Product Service : $REACT_APP_PRODUCT_SERVICE_URL"
echo "  Cart Service    : $REACT_APP_CART_SERVICE_URL"
echo "  Order Service   : $REACT_APP_ORDER_SERVICE_URL"

# Start Nginx
nginx -g "daemon off;"