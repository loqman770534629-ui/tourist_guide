#!/bin/bash

echo "🚀 رفع المشروع إلى GitHub - نسخة سريعة"
echo "=========================================="
echo ""
echo "📝 الصق GitHub Token هنا (لن يظهر):"
read -s TOKEN

echo ""
echo "⏳ جاري الرفع..."

cd "/home/loqman/learn/flutter /tourist_guide"

# رفع المشروع مع Token
git push https://${TOKEN}@github.com/loqman770534629-ui/tourist_guide.git main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅✅✅ نجح الرفع! ✅✅✅"
    echo ""
    echo "🌐 افتح المشروع:"
    echo "https://github.com/loqman770534629-ui/tourist_guide"
    echo ""
else
    echo ""
    echo "❌ فشل الرفع. تحقق من:"
    echo "1. صحة Token"
    echo "2. صلاحية repo في Token"
    echo "3. الاتصال بالإنترنت"
fi

