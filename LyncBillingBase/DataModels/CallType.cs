﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using DALDotNet;
using DALDotNet.DataAccess;
using DALDotNet.DataAttributes;

namespace LyncBillingBase.DataModels
{
    [DataSource(Name = "NEW_CallTypes", Type = GLOBALS.DataSource.Type.DBTable, AccessMethod = GLOBALS.DataSource.AccessMethod.SingleSource)]
    public class CallType : DataModel
    {
        [IsIDField]
        [DbColumn("ID")]
        public int ID { get; set; }

        [DbColumn("TypeID")]
        public int TypeID { get; set; }

        [DbColumn("Name")]
        public string Name { get; set; }

        [AllowNull]
        [DbColumn("Description")]
        public string Description { get; set; }
    }
}
