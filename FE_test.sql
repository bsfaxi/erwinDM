
use ;

db.Auth.dropIndex( "aunmind" );

db.Auth.drop();

use ;

db.Cust.dropIndex( "XIE1Cust" );

db.Cust.drop();

db.Cust.drop();

db.Disc.drop();

db.Job.drop();

db.People.drop();

db.Pmt.drop();

db.Publshr.drop();

db.Rgn.drop();

db.Rylty.drop();

db.createCollection("Auth");

db.Auth.insertOne({
     "Auth_Id": "risus sodales eu ",
     "Auth_Lst_Nam": "arcu molestie ",
     "Auth_Frst_Nam": "a egestas ",
     "Auth_Phn_Nbr": NumberInt(4413),
     "Auth_Addr": "ullamcorper gravida ",
     "Auth_Cty": "molestie semper ",
     "Auth_St": "volutpat ",
     "Auth_Zip_Cd": "vel libero eu ",
     "Cntrct": NumberInt(3169),
     "BookAuth": [
     {
          "Rylty_Pmt": [
          {
               "Pmt_Dt": new Date(),
               "Pmt_Amt": NumberDecimal()
          }
          ]
     }
     ]
});

use ;

db.Auth.createIndex(
{
	"Auth_Lst_Nam": 1,
	"Auth_Frst_Nam": 1
},
{
	"name" : "aunmind"
});

db.createCollection("Cust");

db.Cust.insertOne({
     "Cust_Id": "egestas tincidunt ",
     "Cust_Frst_Nam": "Aenean faucibus a ",
     "Cust_Lst_Nam": "fringilla vel sed ",
     "Cust_Cmpy_Nam": "efficitur ",
     "Cust_Stret_Addr": "at ",
     "Cust_Cty": "vitae sagittis placerat ",
     "Cust_St": "molestie purus sapien ",
     "Cust_Zip_Cd": "gravida ",
     "Cust_Phn_Area_Cd": NumberInt(4367),
     "Cust_Phn_Nbr": NumberInt(6320),
     "Cust_Fax_Area_Cd": NumberInt(8577),
     "Cust_Fax_Nbr": NumberInt(418),
     "Purchase_Ordr": [
     {
          "Ordr_Nbr": NumberInt(3247),
          "Ordr_Dt": new Date(),
          "Pmt_Trm": "Duis sagittis congue ",
          "Ordr_Itm": [
          {
               "Itm_Seq_Nbr": NumberInt(9124),
               "Ordr_Qty": NumberInt(7248),
               "Ordr_Disc_Amt": NumberDecimal(),
               "Ordr_Prc": NumberDecimal(),
               "Rylty_Hist": [
               {
                    "Rylty_Hist_Id": "semper cursus ",
                    "Rylty_Pmt_Dt": new Date(),
                    "Rylty_Pmt_Amt": NumberDecimal(),
                    "Rylty_Payee": "orci lectus sodales "
               }
               ],
               "Book_Retrun": [
               {
                    "Book_Rtrn_Id": "id et ut ",
                    "Book_Rtrn_Dt": new Date()
               }
               ],
               "Ordr_Ship": [
               {
                    "Ordr_Ship_Id": "sit hac urna ",
                    "Blng_Addr": "lectus ",
                    "Ship_Addr": "erat sagittis ",
                    "Ship_Stat": "vel lacinia ",
                    "Shed_Ship_Dt": new Date(),
                    "Bk_Ordr": {
                         "Reschd_Ship_Dt": new Date()
                    }
               }
               ]
          }
          ]
     }
     ]
});

use ;

db.Cust.createIndex(
{
	"Cust_Lst_Nam": 1,
	"Cust_Frst_Nam": 1
},
{
	"name" : "XIE1Cust"
});

db.createCollection("Cust");

db.Cust.insertOne({
     "Cust_ID": NumberInt(6170),
     "Social_Nbr": NumberInt(7797),
     "Phn_Nbr": NumberInt(1069)
});

db.createCollection("Disc");

db.Disc.insertOne({
     "Disc_Typ": "imperdiet ultrices vitae ",
     "Lo_Qty": NumberInt(484),
     "Hi_Qty": NumberInt(5073),
     "Disc_Pct": NumberDecimal(),
     "Ordr_Itm": [
     {
          "Itm_Seq_Nbr": NumberInt(5918),
          "Ordr_Qty": NumberInt(3327),
          "Ordr_Disc_Amt": NumberDecimal(),
          "Ordr_Prc": NumberDecimal(),
          "Rylty_Hist": [
          {
               "Rylty_Hist_Id": "a urna ",
               "Rylty_Pmt_Dt": new Date(),
               "Rylty_Pmt_Amt": NumberDecimal(),
               "Rylty_Payee": "commodo eget at "
          }
          ],
          "Book_Retrun": [
          {
               "Book_Rtrn_Id": "est id ante ",
               "Book_Rtrn_Dt": new Date()
          }
          ],
          "Ordr_Ship": [
          {
               "Ordr_Ship_Id": "eros consequat ",
               "Blng_Addr": "ac amet fermentum ",
               "Ship_Addr": "ac ",
               "Ship_Stat": "sit ",
               "Shed_Ship_Dt": new Date(),
               "Bk_Ordr": {
                    "Reschd_Ship_Dt": new Date()
               }
          }
          ]
     }
     ]
});

db.createCollection("Job");

db.Job.insertOne({
     "Job_Id": "vestibulum ",
     "Job_Desc": "condimentum nisl ",
     "Min_LvL": NumberInt(405),
     "Max_LvL": NumberInt(1107),
     "Emp": [
     {
          "Emp_Id": "efficitur ",
          "Emp_Frst_Nam": "pulvinar lectus tempus ",
          "Emp_Mid_Init": "scelerisque arcu ",
          "Emp_Lst_Nam": "orci eget lectus ",
          "Curr_Emp_Job_Ttle": NumberInt(6462),
          "Emp_Hire_Dt": new Date(),
          "Reporting_Structure": [
          {
               "Strt_Dt": new Date(),
               "End_Dt": new Date()
          }
          ]
     }
     ]
});

db.createCollection("People");

db.People.insertOne({
});

db.createCollection("Pmt");

db.Pmt.insertOne({
     "Pmt_Nbr": NumberInt(3687),
     "Pmt_Typ": "consequat ",
     "Pmt_Dt": new Date(),
     "Pmt_Amt": NumberDecimal(),
     "Crd_Card": {
          "Card_Nbr": NumberInt(7482),
          "Card_Exp_Dt": new Date(),
          "Crd_Card_Typ": "vitae libero felis ",
          "Card_Vndr_Nam": "molestie libero a ",
          "Crd_Card_Amt": NumberDecimal(),
          "Crd_Chk": [
          {
               "Crd_Chk_Evnt": "vel ipsum ut ",
               "Crd_Chk_Dt": new Date(),
               "Crd_Stat": "ultrices "
          }
          ]
     },
     "Mony_Ordr": {
          "Mony_Ordr_Nbr": NumberInt(6315),
          "Mony_Ordr_Amt": NumberDecimal()
     },
     "Personal_Chk": {
          "Chk_Nbr": NumberInt(297),
          "Chk_Acct_Nbr": NumberInt(7740),
          "Chk_Bnk_Nbr": NumberInt(7792),
          "Chk_Dvr_Lic_Nbr": "at ut tempus ",
          "Chk_Amt": NumberDecimal()
     }
});

db.createCollection("Publshr");

db.Publshr.insertOne({
     "Publshr_Id": "orci congue a ",
     "Publshr_Nam": "orci ",
     "Publshr_Addr": "molestie commodo ",
     "Publshr_Cty": "nec ",
     "Publshr_St": "amet ",
     "Publshr_Zip_Cd": "nisi ",
     "Book": [
     {
          "Book_Id": "at lacinia ",
          "Book_Nam": "Ut sed ",
          "Book_Typ": "amet Duis a ",
          "MRSP_Prc": NumberInt(6705),
          "Advnc": NumberInt(8333),
          "Rylty_Trm": NumberInt(3314),
          "Book_Note": "vitae et metus ",
          "Publctn_Dt": new Date(),
          "Ordr_Itm": [
          {
               "Itm_Seq_Nbr": NumberInt(342),
               "Ordr_Qty": NumberInt(7314),
               "Ordr_Disc_Amt": NumberDecimal(),
               "Ordr_Prc": NumberDecimal(),
               "Rylty_Hist": [
               {
                    "Rylty_Hist_Id": "mauris ",
                    "Rylty_Pmt_Dt": new Date(),
                    "Rylty_Pmt_Amt": NumberDecimal(),
                    "Rylty_Payee": "leo "
               }
               ],
               "Book_Retrun": [
               {
                    "Book_Rtrn_Id": "efficitur ",
                    "Book_Rtrn_Dt": new Date()
               }
               ],
               "Ordr_Ship": [
               {
                    "Ordr_Ship_Id": "semper luctus ",
                    "Blng_Addr": "Aliquam dictum consequat ",
                    "Ship_Addr": "turpis ut pulvinar ",
                    "Ship_Stat": "ultrices ",
                    "Shed_Ship_Dt": new Date(),
                    "Bk_Ordr": {
                         "Reschd_Ship_Dt": new Date()
                    }
               }
               ]
          }
          ],
          "Book_YTD_Sls": {
               "Yr_To_Dt_Sls_Amt": NumberDecimal(),
               "Yr_To_Dt_Sls_Dt": new Date()
          },
          "BookAuth": [
          {
               "Rylty_Pmt": [
               {
                    "Pmt_Dt": new Date(),
                    "Pmt_Amt": NumberDecimal()
               }
               ]
          }
          ]
     }
     ],
     "Publshr_Logo": {
          "Publshr_Logo": "est sapien ",
          "Publshr_Publc_Rel_Inf": "at a "
     }
});

db.createCollection("Rgn");

db.Rgn.insertOne({
     "Rgn_Id": "orci sed ",
     "Rgn_Area": "vel sed nisi ",
     "Rgn_Desc": "sit sed ",
     "Stor_Nam": [
     {
          "Stor_Id": "ut ",
          "Stor_Nam": "volutpat condimentum fermentum ",
          "Stor_Addr": "at a ",
          "Stor_Cty": "sed sit ",
          "Stor_St": "efficitur consectetur ",
          "Stor_Zip_Cd": "pellentesque turpis ",
          "Purchase_Ordr": [
          {
               "Ordr_Nbr": NumberInt(3004),
               "Ordr_Dt": new Date(),
               "Pmt_Trm": "eu hendrerit egestas ",
               "Ordr_Itm": [
               {
                    "Itm_Seq_Nbr": NumberInt(9668),
                    "Ordr_Qty": NumberInt(5497),
                    "Ordr_Disc_Amt": NumberDecimal(),
                    "Ordr_Prc": NumberDecimal(),
                    "Rylty_Hist": [
                    {
                         "Rylty_Hist_Id": "euismod vehicula ",
                         "Rylty_Pmt_Dt": new Date(),
                         "Rylty_Pmt_Amt": NumberDecimal(),
                         "Rylty_Payee": "odio "
                    }
                    ],
                    "Book_Retrun": [
                    {
                         "Book_Rtrn_Id": "imperdiet a ",
                         "Book_Rtrn_Dt": new Date()
                    }
                    ],
                    "Ordr_Ship": [
                    {
                         "Ordr_Ship_Id": "a lectus ",
                         "Blng_Addr": "orci ex quis ",
                         "Ship_Addr": "et ",
                         "Ship_Stat": "at purus ",
                         "Shed_Ship_Dt": new Date(),
                         "Bk_Ordr": {
                              "Reschd_Ship_Dt": new Date()
                         }
                    }
                    ]
               }
               ]
          }
          ]
     }
     ]
});

db.createCollection("Rylty");

db.Rylty.insertOne({
     "Rylty_Id": "urna sagittis ",
     "Lo_Rnge": NumberInt(2712),
     "Hi_Rnge": NumberInt(1664),
     "Rylty_Amt": NumberDecimal(),
     "Rylty_Pmt": [
     {
          "Pmt_Dt": new Date(),
          "Pmt_Amt": NumberDecimal()
     }
     ]
});