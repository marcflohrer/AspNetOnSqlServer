using System;
using System.Threading.Tasks;
using Xunit;

namespace my_demo_app_tests
{
    public class AsyncExamples
    {
        internal async void CodeThrowsAsync()
        {
            Task testCode() => Task.Factory.StartNew(ThrowingMethod);

            var ex = await Assert.ThrowsAsync<NotImplementedException>(testCode);

            Assert.IsType<NotImplementedException>(ex);
        }

        [Fact]
        public async void RecordAsync()
        {
            Task testCode() => Task.Factory.StartNew(ThrowingMethod);

            var ex = await Record.ExceptionAsync(testCode);

            Assert.IsType<NotImplementedException>(ex);
        }

        void ThrowingMethod()
        {
            throw new NotImplementedException();
        }
    }
}
