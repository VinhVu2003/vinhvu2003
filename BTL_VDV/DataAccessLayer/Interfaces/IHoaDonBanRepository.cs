using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public partial interface IHoaDonBanRepository

    {
        bool Create(HoaDonModel model);
        bool Update(HoaDonModel model);
    }
}
