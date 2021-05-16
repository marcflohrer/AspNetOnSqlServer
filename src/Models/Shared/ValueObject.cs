using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace MyDemoApp.Models.Shared
{
    // source: https://github.com/jhewlett/ValueObject
    public abstract class ValueObject : IEquatable<ValueObject>
    {
        private List<PropertyInfo> properties;
        private List<FieldInfo> fields;

        public static bool operator ==(ValueObject obj1, ValueObject obj2)
        {
            if (object.Equals(obj1, null))
            {
                if (object.Equals(obj2, null))
                {
                    return true;
                }
                return false;
            }
            return obj1.Equals(obj2);
        }

        public static bool operator !=(ValueObject obj1, ValueObject obj2)
        {
            return !(obj1 == obj2);
        }

        public bool Equals(ValueObject obj)
        {
            return Equals(obj as object);
        }

        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType()) return false;

            var isEqual = GetProperties().All(p => PropertiesAreEqual(obj, p))
                && GetFields().All(f => FieldsAreEqual(obj, f));
            return isEqual;
        }

        private bool PropertiesAreEqual(object obj, PropertyInfo p)
        {
            var isEqual = object.Equals(p.GetValue(this, null), p.GetValue(obj, null));
            if(!isEqual && p.GetValue(this, null).GetType() == typeof(System.Double)){
                isEqual = Math.Abs((double)p.GetValue(this, null) - (double)p.GetValue(obj, null)) <= Double.Epsilon;
            }
            if(!isEqual){
                Console.WriteLine($"Not Equal: {p}");
            }
            return isEqual;
        }

        private bool FieldsAreEqual(object obj, FieldInfo f)
        {
            var isEqual = object.Equals(f.GetValue(this), f.GetValue(obj));
            if(!isEqual){
                Console.WriteLine($"Not Equal: {f}");
            }
            return isEqual;
        }

        private IEnumerable<PropertyInfo> GetProperties()
        {
            if (this.properties == null)
            {
                this.properties = GetType()
                    .GetProperties(BindingFlags.Instance | BindingFlags.Public)
                    .Where(p => p.GetCustomAttribute(typeof(IgnoreMemberAttribute)) == null)
                    .ToList();
            }

            return this.properties;
        }

        private IEnumerable<FieldInfo> GetFields()
        {
            if (this.fields == null)
            {
                this.fields = GetType().GetFields(BindingFlags.Instance | BindingFlags.Public)
                    .Where(p => p.GetCustomAttribute(typeof(IgnoreMemberAttribute)) == null)
                    .ToList();
            }

            return this.fields;
        }

        public override int GetHashCode()
        {
            unchecked   //allow overflow
            {
                int hash = 17;
                foreach (var prop in GetProperties())
                {
                    var value = prop.GetValue(this, null);
                    hash = HashValue(hash, value);
                }

                foreach (var field in GetFields())
                {
                    var value = field.GetValue(this);
                    hash = HashValue(hash, value);
                }

                return hash;
            }
        }

        private int HashValue(int seed, object value)
        {
            var currentHash = value != null
                ? value.GetHashCode()
                : 0;

            return seed * 23 + currentHash;
        }
    }
}