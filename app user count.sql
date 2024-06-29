select 
[Registered Date] ,
[Outlet Name],
count([Registered Date]) as cus 
from qry_CustomerRegistered
Where [Registered Date] between '5-1-2024' and GETDATE()
		
group by 
[Registered Date],
[Outlet Name]
order by 
[Registered Date] desc