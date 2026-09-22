-- ---------------------------------------------------------------
-- erwin Data Modeler — QDM model artifact
-- Mart-Path: Mart://Mart/Product Digital Platform/Product And Pricing Domain/ABB Purchase Orders Management/PurchasingAndLogisticsCorePhysical
-- Mart-Version: 2
-- Mart-Full-Path: Mart://Mart/Product Digital Platform/Product And Pricing Domain/ABB Purchase Orders Management/PurchasingAndLogisticsCorePhysical : v2
-- Model-Name: PurchasingAndLogisticsCorePhysical
-- Model-Long-Id: {E694D3B2-FF9C-4022-B99B-6EFB3EAF843A}+00000000
-- Catalog-Id: e694d3b2-ff9c-4022-b99b-6efb3eaf843a
-- ---------------------------------------------------------------

-- Create table `DeliverySimulation`
CREATE TABLE `DeliverySimulation` (
  `DeliverySimulationId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the delivery simulation record."),
  `SimulationReference` STRING NOT NULL OPTIONS (description = "Reference identifier for the delivery simulation scenario."),
  `SimulatedDeliveryDateUtc` TIMESTAMP NOT NULL OPTIONS (description = "Simulated delivery date and time in UTC."),
  `SimulatedQuantity` NUMERIC NOT NULL OPTIONS (description = "Simulated quantity to be delivered."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the delivery simulation scenario is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the delivery simulation record was created.")
)
OPTIONS (
  description = "Represents simulations of delivery scenarios to evaluate dates, quantities, and logistics."
);

-- Create table `BuyerSite`
CREATE TABLE `BuyerSite` (
  `BuyerSiteId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Unique identifier of the buyer site."),
  `BuyerSiteCode` STRING NOT NULL OPTIONS (description = "Code used to identify the buyer site."),
  `BuyerSiteName` STRING NOT NULL OPTIONS (description = "Name of the buyer site or location."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the buyer site is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "Timestamp in UTC when the buyer site record was created.")
)
OPTIONS (
  description = "Represents a buyer-facing site or digital location used for product and supplier interactions in the product digital platform."
);

-- Create table `SupplierProductInformation`
CREATE TABLE `SupplierProductInformation` (
  `SupplierProductInformationId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the supplier product information record."),
  `SupplierProductCode` STRING NOT NULL OPTIONS (description = "Product code as defined by the supplier."),
  `BuyerProductCode` STRING OPTIONS (description = "Corresponding product code as defined by the buyer."),
  `ProductDescription` STRING OPTIONS (description = "Description of the product."),
  `UnitOfMeasure` STRING NOT NULL OPTIONS (description = "Unit of measure used for purchasing this product."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the supplier product information is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the supplier product information record was created.")
)
OPTIONS (
  description = "Represents detailed product information provided by suppliers, including identifiers and characteristics."
);

-- Create table `PurchaseOrdersManagement`
CREATE TABLE `PurchaseOrdersManagement` (
  `PurchaseOrdersManagementId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the purchase orders management record."),
  `PurchaseOrderNumber` NUMERIC NOT NULL OPTIONS (description = "Identifier of the managed purchase order."),
  `PurchaseOrderStatus` STRING NOT NULL OPTIONS (description = "Status of the purchase order (e.g., Open, Closed, Cancelled)."),
  `OrderDateUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the purchase order was created."),
  `ExpectedDeliveryDateUtc` TIMESTAMP OPTIONS (description = "UTC timestamp when the delivery of the purchase order is expected."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the purchase order record is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the purchase orders management record was created.")
)
OPTIONS (
  description = "Represents the management of purchase orders throughout their lifecycle."
);

-- Create table `DeliveryLocation`
CREATE TABLE `DeliveryLocation` (
  `DeliveryLocationId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the delivery location record."),
  `DeliveryLocationCode` STRING NOT NULL OPTIONS (description = "Code identifying the delivery location."),
  `DeliveryLocationName` STRING NOT NULL OPTIONS (description = "Name of the delivery location."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the delivery location is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the delivery location record was created."),
  `DeliverySimulationId` INT64,
  FOREIGN KEY (`DeliverySimulationId`) REFERENCES `DeliverySimulation` (`DeliverySimulationId`) NOT ENFORCED
)
OPTIONS (
  description = "Represents the location where goods are delivered to the buyer."
);

-- Create table `Incoterm`
CREATE TABLE `Incoterm` (
  `IncotermId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the Incoterm record."),
  `IncotermCode` STRING NOT NULL OPTIONS (description = "Code identifying the Incoterm (e.g., FOB, CIF)."),
  `IncotermDescription` STRING OPTIONS (description = "Description of the Incoterm terms."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the Incoterm is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the Incoterm record was created."),
  `SupplierCommercialManagementId` INT64,
  FOREIGN KEY (`SupplierCommercialManagementId`) REFERENCES `SupplierCommercialManagement` (`SupplierCommercialManagementId`) NOT ENFORCED
)
OPTIONS (
  description = "Represents international commercial terms (Incoterms) defining delivery responsibilities and risks."
);

-- Create table `SupplierCommercialManagement`
CREATE TABLE `SupplierCommercialManagement` (
  `SupplierCommercialManagementId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the supplier commercial management record."),
  `AgreementReference` STRING NOT NULL OPTIONS (description = "Reference identifier for the commercial agreement with the supplier."),
  `AgreementStartDateUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the commercial agreement starts."),
  `AgreementEndDateUtc` TIMESTAMP OPTIONS (description = "UTC timestamp when the commercial agreement ends."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the commercial agreement is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the supplier commercial management record was created.")
)
OPTIONS (
  description = "Represents commercial agreements and conditions managed with suppliers."
);

-- Create table `ShippingLocation`
CREATE TABLE `ShippingLocation` (
  `ShippingLocationId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the shipping location record."),
  `ShippingLocationCode` STRING NOT NULL OPTIONS (description = "Code identifying the shipping location."),
  `ShippingLocationName` STRING NOT NULL OPTIONS (description = "Name of the shipping location."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the shipping location is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the shipping location record was created."),
  `ReplenishmentExecutionAndAllocationId` INT64,
  FOREIGN KEY (`ReplenishmentExecutionAndAllocationId`) REFERENCES `ReplenishmentExecutionAndAllocation` (`ReplenishmentExecutionAndAllocationId`) NOT ENFORCED
)
OPTIONS (
  description = "Represents locations from which goods are shipped to buyers."
);

-- Create table `PurchaseOrderResponse`
CREATE TABLE `PurchaseOrderResponse` (
  `PurchaseOrderResponseId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the purchase order response record."),
  `PurchaseOrderNumber` STRING NOT NULL OPTIONS (description = "Identifier of the related purchase order."),
  `ResponseStatus` STRING NOT NULL OPTIONS (description = "Status of the purchase order response (e.g., Accepted, Rejected, Modified)."),
  `ResponseDateUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the purchase order response was issued."),
  `IsFinalResponse` BOOL NOT NULL OPTIONS (description = "Indicates whether this response is the final one for the purchase order."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the purchase order response record was created."),
  `PurchaseOrdersManagementId` INT64,
  FOREIGN KEY (`PurchaseOrdersManagementId`) REFERENCES `PurchaseOrdersManagement` (`PurchaseOrdersManagementId`) NOT ENFORCED
)
OPTIONS (
  description = "Represents a suppliers response to a purchase order, including confirmations and changes."
);

-- Create table `InvoicingLocation`
CREATE TABLE `InvoicingLocation` (
  `InvoicingLocationId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the invoicing location record."),
  `InvoicingLocationCode` STRING NOT NULL OPTIONS (description = "Code identifying the invoicing location."),
  `InvoicingLocationName` STRING NOT NULL OPTIONS (description = "Name of the invoicing location."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the invoicing location is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the invoicing location record was created."),
  `PurchaseOrdersManagementId` INT64,
  FOREIGN KEY (`PurchaseOrdersManagementId`) REFERENCES `PurchaseOrdersManagement` (`PurchaseOrdersManagementId`) NOT ENFORCED
)
OPTIONS (
  description = "Represents the location or entity to which supplier invoices are sent and processed."
);

-- Create table `PurchasePriceCondition`
CREATE TABLE `PurchasePriceCondition` (
  `PurchasePriceConditionId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the purchase price condition record."),
  `ConditionCode` STRING NOT NULL OPTIONS (description = "Code identifying the price condition (e.g., discount type)."),
  `ConditionDescription` STRING OPTIONS (description = "Description of the price condition."),
  `ConditionType` STRING NOT NULL OPTIONS (description = "Type of the price condition (e.g., percentage, amount)."),
  `ConditionValue` NUMERIC NOT NULL OPTIONS (description = "Value of the price condition (percentage or amount)."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the price condition is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the purchase price condition record was created."),
  `StandardPurchasePriceAndPurchasePriceConditionId` INT64,
  FOREIGN KEY (`StandardPurchasePriceAndPurchasePriceConditionId`) REFERENCES `StandardPurchasePriceAndPurchasePriceCondition` (`StandardPurchasePriceAndPurchasePriceConditionId`) NOT ENFORCED
)
OPTIONS (
  description = "Represents specific conditions that affect purchase pricing, such as discounts or surcharges."
);

-- Create table `StandardPurchasePriceAndPurchasePriceCondition`
CREATE TABLE `StandardPurchasePriceAndPurchasePriceCondition` (
  `StandardPurchasePriceAndPurchasePriceConditionId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the association between standard purchase price and purchase price condition."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the association record is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the association record was created.")
)
OPTIONS (
  description = "Represents the association between standard purchase prices and purchase price conditions."
);

-- Create table `ReplenishmentExecutionAndAllocation`
CREATE TABLE `ReplenishmentExecutionAndAllocation` (
  `ReplenishmentExecutionAndAllocationId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the replenishment execution and allocation record."),
  `ReplenishmentReference` STRING NOT NULL OPTIONS (description = "Reference identifier for the replenishment execution."),
  `AllocationStatus` STRING NOT NULL OPTIONS (description = "Status of the allocation (e.g., Planned, Executed)."),
  `ExecutionDateUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the replenishment execution took place."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the replenishment record is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the replenishment execution and allocation record was created.")
)
OPTIONS (
  description = "Represents processes for executing replenishment and allocating stock to orders."
);

-- Create table `StandardPurchasePrice`
CREATE TABLE `StandardPurchasePrice` (
  `StandardPurchasePriceId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the standard purchase price record."),
  `StandardPriceAmount` NUMERIC NOT NULL OPTIONS (description = "Standard purchase price amount for the product."),
  `CurrencyCode` STRING NOT NULL OPTIONS (description = "Currency code for the standard purchase price (e.g., USD, EUR)."),
  `EffectiveStartDateUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the standard purchase price becomes effective."),
  `EffectiveEndDateUtc` TIMESTAMP OPTIONS (description = "UTC timestamp when the standard purchase price is no longer effective."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the standard purchase price is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the standard purchase price record was created."),
  `PricingManagementId` INT64,
  FOREIGN KEY (`PricingManagementId`) REFERENCES `PricingManagement` (`PricingManagementId`) NOT ENFORCED
)
OPTIONS (
  description = "Represents the standard purchase price for a product, independent of conditions."
);

-- Create table `Accounting`
CREATE TABLE `Accounting` (
  `AccountingId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the accounting record related to supplier transactions."),
  `AccountingDocumentNumber` STRING NOT NULL OPTIONS (description = "Identifier of the accounting document (e.g., invoice, voucher)."),
  `PostingDateUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the accounting posting occurred."),
  `DocumentAmount` NUMERIC NOT NULL OPTIONS (description = "Monetary amount of the accounting document."),
  `CurrencyCode` STRING NOT NULL OPTIONS (description = "Currency code of the accounting document (e.g., USD, EUR)."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the accounting record is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the accounting record was created.")
)
OPTIONS (
  description = "Represents accounting information and postings related to supplier transactions."
);

-- Create table `PricingManagement`
CREATE TABLE `PricingManagement` (
  `PricingManagementId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Primary key for the pricing management record."),
  `PricingRuleCode` STRING NOT NULL OPTIONS (description = "Code identifying the pricing rule."),
  `PricingRuleDescription` STRING OPTIONS (description = "Description of the pricing rule."),
  `EffectiveStartDateUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the pricing rule becomes effective."),
  `EffectiveEndDateUtc` TIMESTAMP OPTIONS (description = "UTC timestamp when the pricing rule is no longer effective."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the pricing rule is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the pricing management record was created.")
)
OPTIONS (
  description = "Represents pricing management processes and rules for purchased products."
);

-- Create table `Supplier`
CREATE TABLE `Supplier` (
  `SupplierId` INT64 PRIMARY KEY NOT ENFORCED NOT NULL OPTIONS (description = "Unique identifier of the supplier."),
  `SupplierCode` STRING NOT NULL OPTIONS (description = "Business code used to identify the supplier."),
  `SupplierName` STRING NOT NULL OPTIONS (description = "Official name of the supplier organization."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the supplier is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "Timestamp in UTC when the supplier record was created."),
  `AccountingId` INT64,
  FOREIGN KEY (`AccountingId`) REFERENCES `Accounting` (`AccountingId`) NOT ENFORCED
)
OPTIONS (
  description = "Represents a business partner providing goods or services, used across purchasing and accounting processes."
);

-- Create table `PurchaseOrderResponseLine`
CREATE TABLE `PurchaseOrderResponseLine` (
  `PurchaseOrderResponseLineId` INT64 NOT NULL OPTIONS (description = "Primary key for the purchase order response line record."),
  `PurchaseOrdersManagementId` INT64,
  `LineNumber` INT64 NOT NULL OPTIONS (description = "Line number within the purchase order response."),
  `OrderedQuantity` NUMERIC NOT NULL OPTIONS (description = "Quantity originally ordered on the line."),
  `ConfirmedQuantity` NUMERIC NOT NULL OPTIONS (description = "Quantity confirmed by the supplier on the line."),
  `UnitPriceAmount` NUMERIC NOT NULL OPTIONS (description = "Unit price amount for the line item."),
  `CurrencyCode` STRING NOT NULL OPTIONS (description = "Currency code for the line price."),
  `ExpectedDeliveryDateUtc` TIMESTAMP OPTIONS (description = "Expected delivery date for the line item in UTC."),
  `IsActive` BOOL NOT NULL OPTIONS (description = "Indicates whether the purchase order response line is currently active."),
  `CreatedAtUtc` TIMESTAMP NOT NULL OPTIONS (description = "UTC timestamp when the purchase order response line record was created."),
  PRIMARY KEY (`PurchaseOrderResponseLineId`, `PurchaseOrdersManagementId`) NOT ENFORCED,
  FOREIGN KEY (`PurchaseOrdersManagementId`) REFERENCES `PurchaseOrdersManagement` (`PurchaseOrdersManagementId`) NOT ENFORCED
)
OPTIONS (
  description = "Represents individual line items within a purchase order response."
);
