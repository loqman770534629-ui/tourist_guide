#!/bin/bash

# دليل رفع المشروع إلى GitHub
# استخدم هذا السكريبت بعد الحصول على Token

echo "🚀 رفع المشروع إلى GitHub"
echo "================================"
echo ""

# اسأل عن Token
echo "📝 الرجاء إدخال GitHub Personal Access Token:"
echo "(احصل عليه من: https://github.com/settings/tokens/new)"
echo ""
read -s GITHUB_TOKEN

echo ""
echo "⏳ جاري رفع المشروع..."
echo ""

cd "/home/loqman/learn/flutter /tourist_guide"

# تحديث Remote URL بإضافة Token
git remote set-url origin https://${GITHUB_TOKEN}@github.com/loqman770534629-ui/tourist_guide.git

# رفع المشروع
git push -u origin main

if [ $PUSH_STATUS -eq 0 ]; then
    echo ""
    echo "✅ تم رفع المشروع بنجاح!"
    echo "🌐 افتح: https://github.com/loqman770534629-ui/tourist_guide"
    echo ""
    
    # إزالة Token من URL للأمان
    git remote set-url origin https://github.com/loqman770534629-ui/tourist_guide.git
else
    echo ""
    echo "❌ حدث خطأ في الرفع"
    echo "تحقق من:"
    echo "1. صحة التوكن"
    echo "2. صلاحيات التوكن (repo)"
    echo "3. الاتصال بالإنترنت"
fi

