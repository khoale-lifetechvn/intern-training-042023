S.O.L.I.D
S - Nguyên tắc Trách nhiệm Đơn lẻ (Single Responsibility Principle): Một lớp chỉ nên có một lý do để thay đổi.
O - Nguyên tắc Mở/Đóng (Open-Closed Principle): Các thực thể phần mềm (lớp, module, chức năng, v.v.) nên mở để mở rộng nhưng đóng để sửa đổi.
L - Nguyên tắc Thay thế Liskov (Liskov Substitution Principle): Các chức năng sử dụng con trỏ hoặc tham chiếu đến các lớp cơ sở phải có thể sử dụng các đối tượng của các lớp kế thừa mà không cần biết.
I - Nguyên tắc Phân chia Giao diện (Interface Segregation Principle): Khách hàng không nên bị ép buộc phụ thuộc vào các giao diện mà họ không sử dụng.
D - Nguyên tắc Đảo ngược Phụ thuộc (Dependency Inversion Principle): Phụ thuộc vào các trừu tượng, không phải là các cụ thể.

//----S----//
S - Nguyên tắc Trách nhiệm Đơn lẻ (Single Responsibility Principle): Một lớp chỉ nên có một lý do để thay đổi.

Dưới đây là một ví dụ minh họa cho Nguyên tắc Trách nhiệm Đơn lẻ (Single Responsibility Principle) trong S.O.L.I.D:

public class Book
{
    public string Title { get; set; }
    public string Author { get; set; }
    public string ISBN { get; set; }

    public void Save()
    {
        // Code to save book to database
    }
}

Trong ví dụ trên, lớp Book có hai trách nhiệm: lưu trữ thông tin về một cuốn sách và lưu trữ cuốn sách vào cơ sở dữ liệu. 
Điều này vi phạm Nguyên tắc Trách nhiệm Đơn lẻ vì có nhiều hơn một lý do để thay đổi lớp Book: thay đổi cách lưu trữ thông tin về sách hoặc thay đổi cách lưu trữ sách vào cơ sở dữ liệu.
Để tuân thủ Nguyên tắc Trách nhiệm Đơn lẻ, chúng ta có thể tách lớp Book thành hai lớp riêng biệt, mỗi lớp chỉ có một trách nhiệm:

public class Book
{
    public string Title { get; set; }
    public string Author { get; set; }
    public string ISBN { get; set; }
}

public class BookRepository
{
    public void Save(Book book)
    {
        // Code to save book to database
    }
}

Trong ví dụ trên, lớp Book chỉ có trách nhiệm lưu trữ thông tin về một cuốn sách và lớp BookRepository chỉ có trách nhiệm lưu trữ cuốn sách vào cơ sở dữ liệu. 
Mỗi lớp chỉ có một lý do để thay đổi và do đó tuân thủ Nguyên tắc Trách nhiệm Đơn lẻ.

//----O----//
O - Nguyên tắc Mở/Đóng (Open-Closed Principle): Các thực thể phần mềm (lớp, module, chức năng, v.v.) nên mở để mở rộng nhưng đóng để sửa đổi.

Dưới đây là một ví dụ minh họa cho Nguyên tắc Mở/Đóng (Open-Closed Principle) trong S.O.L.I.D:

public class Rectangle
{
    public double Width { get; set; }
    public double Height { get; set; }
}

public class Circle
{
    public double Radius { get; set; }
}

public class AreaCalculator
{
    public double TotalArea(object[] shapes)
    {
        double area = 0;
        foreach (var shape in shapes)
        {
            if (shape is Rectangle)
            {
                Rectangle rectangle = (Rectangle)shape;
                area += rectangle.Width * rectangle.Height;
            }
            else if (shape is Circle)
            {
                Circle circle = (Circle)shape;
                area += circle.Radius * circle.Radius * Math.PI;
            }
        }
        return area;
    }
}

Trong ví dụ trên, lớp AreaCalculator có một phương thức TotalArea để tính tổng diện tích của một mảng các hình. 
Tuy nhiên, phương thức này vi phạm Nguyên tắc Mở/Đóng vì nếu chúng ta muốn thêm một loại hình mới (ví dụ: tam giác), chúng ta sẽ phải sửa đổi mã nguồn của phương thức TotalArea để thêm một trường hợp mới.
Để tuân thủ Nguyên tắc Mở/Đóng, chúng ta có thể tạo ra một lớp trừu tượng Shape với một phương thức trừu tượng Area và cho các lớp Rectangle, Circle và các lớp hình khác kế thừa từ lớp Shape và ghi đè phương thức Area. 
Sau đó, chúng ta có thể sửa đổi phương thức TotalArea để sử dụng phương thức Area của lớp Shape:

public abstract class Shape
{
    public abstract double Area();
}

public class Rectangle : Shape
{
    public double Width { get; set; }
    public double Height { get; set; }

    public override double Area()
    {
        return Width * Height;
    }
}

public class Circle : Shape
{
    public double Radius { get; set; }

    public override double Area()
    {
        return Radius * Radius * Math.PI;
    }
}

public class AreaCalculator
{
    public double TotalArea(Shape[] shapes)
    {
        double area = 0;
        foreach (var shape in shapes)
        {
            area += shape.Area();
        }
        return area;
    }
}

Trong ví dụ trên, phương thức TotalArea không còn phụ thuộc vào các loại hình cụ thể và do đó không cần phải sửa đổi khi chúng ta muốn thêm một loại hình mới. 
Chúng ta chỉ cần tạo ra một lớp mới kế thừa từ lớp Shape và ghi đè phương thức Area. Như vậy, lớp AreaCalculator tuân thủ Nguyên tắc Mở/Đóng.

//----L----//
L - Nguyên tắc Thay thế Liskov (Liskov Substitution Principle): Các chức năng sử dụng con trỏ hoặc tham chiếu đến các lớp cơ sở phải có thể sử dụng các đối tượng của các lớp kế thừa mà không cần biết.

Dưới đây là một ví dụ minh họa cho Nguyên tắc Thay thế Liskov (Liskov Substitution Principle) trong S.O.L.I.D:

public class Bird
{
    public virtual void Fly()
    {
        Console.WriteLine("I can fly");
    }
}

public class Penguin : Bird
{
    public override void Fly()
    {
        throw new Exception("I can't fly");
    }
}

Trong ví dụ trên, lớp Penguin kế thừa từ lớp Bird và ghi đè phương thức Fly. Tuy nhiên, phương thức Fly của lớp Penguin ném ra một ngoại lệ vì chim cánh cụt không thể bay. 
Điều này vi phạm Nguyên tắc Thay thế Liskov vì nó làm cho lớp Penguin không thể thay thế lớp Bird một cách an toàn.
Để tuân thủ Nguyên tắc Thay thế Liskov, chúng ta có thể tách phương thức Fly ra khỏi lớp Bird và tạo ra một lớp mới FlyingBird kế thừa từ lớp Bird và có phương thức Fly. 
Sau đó, chúng ta có thể cho các loại chim có thể bay kế thừa từ lớp FlyingBird:

public class Bird
{
}

public class FlyingBird : Bird
{
    public void Fly()
    {
        Console.WriteLine("I can fly");
    }
}

public class Penguin : Bird
{
}

Trong ví dụ trên, lớp Penguin không còn ghi đè phương thức Fly và do đó không còn vi phạm Nguyên tắc Thay thế Liskov. Lớp Penguin có thể được sử dụng để thay thế lớp Bird một cách an toàn.

//----I----//
I - Nguyên tắc Phân chia Giao diện (Interface Segregation Principle): Khách hàng không nên bị ép buộc phụ thuộc vào các giao diện mà họ không sử dụng.

Dưới đây là một ví dụ minh họa cho Nguyên tắc Phân chia Giao diện (Interface Segregation Principle) trong S.O.L.I.D:

public interface IWorker
{
    void Work();
    void Eat();
}

public class Worker : IWorker
{
    public void Work()
    {
        // Working...
    }

    public void Eat()
    {
        // Eating...
    }
}

public class Robot : IWorker
{
    public void Work()
    {
        // Working...
    }

    public void Eat()
    {
        // Robots do not eat!
        throw new NotImplementedException();
    }
}

Trong ví dụ trên, chúng ta có một giao diện IWorker với hai phương thức Work và Eat. 
Lớp Worker và lớp Robot đều kế thừa từ giao diện IWorker và cài đặt các phương thức của nó. 
Tuy nhiên, lớp Robot không cần phương thức Eat và do đó phải ném ra một ngoại lệ khi phương thức này được gọi. 
Điều này vi phạm Nguyên tắc Phân chia Giao diện vì lớp Robot bị ép buộc phụ thuộc vào một giao diện mà nó không sử dụng.
Để tuân thủ Nguyên tắc Phân chia Giao diện, chúng ta có thể tách giao diện IWorker thành hai giao diện riêng biệt: 
một giao diện IWorkable với phương thức Work và một giao diện IEatable với phương thức Eat. 
Sau đó, chúng ta có thể cho lớp Worker kế thừa từ cả hai giao diện và cho lớp Robot chỉ kế thừa từ giao diện IWorkable:

public interface IWorkable
{
    void Work();
}

public interface IEatable
{
    void Eat();
}

public class Worker : IWorkable, IEatable
{
    public void Work()
    {
        // Working...
    }

    public void Eat()
    {
        // Eating...
    }
}

public class Robot : IWorkable
{
    public void Work()
    {
        // Working...
    }
}

Trong ví dụ trên, lớp Robot không còn bị ép buộc phải cài đặt phương thức Eat và do đó không còn vi phạm Nguyên tắc Phân chia Giao diện. 
Lớp Robot chỉ phụ thuộc vào giao diện mà nó sử dụng.

//----D----//
D - Nguyên tắc Đảo ngược Phụ thuộc (Dependency Inversion Principle): Phụ thuộc vào các trừu tượng, không phải là các cụ thể.

Dưới đây là một ví dụ minh họa cho Nguyên tắc Đảo ngược Phụ thuộc (Dependency Inversion Principle) trong S.O.L.I.D:

public class Email
{
    public void SendEmail()
    {
        // Code to send email
    }
}

public class Notification
{
    private Email _email;

    public Notification()
    {
        _email = new Email();
    }

    public void SendNotification()
    {
        _email.SendEmail();
    }
}

Trong ví dụ trên, lớp Notification phụ thuộc trực tiếp vào lớp Email để gửi email. 
Điều này vi phạm Nguyên tắc Đảo ngược Phụ thuộc vì nó làm cho lớp Notification phụ thuộc vào một cài đặt cụ thể của việc gửi email. 
Nếu chúng ta muốn thay đổi cách gửi email (ví dụ: sử dụng một dịch vụ gửi email khác), chúng ta sẽ phải sửa đổi mã nguồn của lớp Notification.
Để tuân thủ Nguyên tắc Đảo ngược Phụ thuộc, chúng ta có thể tạo ra một giao diện IEmailService với một phương thức SendEmail và cho lớp Email cài đặt giao diện này. 
Sau đó, chúng ta có thể sửa đổi lớp Notification để nhận một đối tượng IEmailService thông qua hàm tạo và sử dụng đối tượng này để gửi email:

public interface IEmailService
{
    void SendEmail();
}

public class Email : IEmailService
{
    public void SendEmail()
    {
        // Code to send email
    }
}

public class Notification
{
    private IEmailService _emailService;

    public Notification(IEmailService emailService)
    {
        _emailService = emailService;
    }

    public void SendNotification()
    {
        _emailService.SendEmail();
    }
}

Trong ví dụ trên, lớp Notification không còn phụ thuộc trực tiếp vào lớp Email mà chỉ phụ thuộc vào giao diện IEmailService. 
Điều này cho phép chúng ta thay đổi cách gửi email mà không cần sửa đổi mã nguồn của lớp Notification. 
Chúng ta chỉ cần tạo ra một lớp mới cài đặt giao diện IEmailService và truyền một đối tượng của lớp này vào hàm tạo của lớp Notification.
