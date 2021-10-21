Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325C643662B
	for <lists+linux-s390@lfdr.de>; Thu, 21 Oct 2021 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhJUP1J (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 21 Oct 2021 11:27:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232248AbhJUP0r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Oct 2021 11:26:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LEBKwn009389;
        Thu, 21 Oct 2021 11:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AmsSE3nC4UClOY1jYZ52LkQpg1P/K6ExubPsUSNbQ7c=;
 b=B3M01U5cBana/jd6kH/tGxPL0osCArXMSeBpQTMYNmdVy4n8o6mIH92CaKWpwtFXDc2A
 LRk5t8GN4cuAXMoEzh2vMYRV3AYjvGK93HpxOVn7slZuU82x1g/9Hi8XS0TlGI2Gs2OA
 Txox363NKEMYv1dBA0eO7HjfVdiMNGVspQAPciS1a76dyU44+cY9KUlYgzN8BXeWZivG
 0+MQkjlEKpeBeooIg1RWXDfvOacU7RDI51QM2HInoY/xNN4UypObP7XswoXHXxaRqOcI
 3mN5SUXxUpxLplmN+LZ4pp4YdUgFFpLJnfffpNwkTAxQX0DQDrp3f4BAjP2nHdYsE6XL rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bu772wps2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 11:24:29 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LF1tjw020644;
        Thu, 21 Oct 2021 11:24:28 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bu772wprr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 11:24:28 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LF2LU7000328;
        Thu, 21 Oct 2021 15:24:27 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3bqpcdr7ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 15:24:27 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LFOP5i48234812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 15:24:25 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7A82BE05B;
        Thu, 21 Oct 2021 15:24:25 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B1CABE086;
        Thu, 21 Oct 2021 15:24:23 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com.com (unknown [9.160.98.118])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 21 Oct 2021 15:24:22 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, freude@linux.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v17 15/15] s390/vfio-ap: update docs to include dynamic config support
Date:   Thu, 21 Oct 2021 11:23:32 -0400
Message-Id: <20211021152332.70455-16-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021152332.70455-1-akrowiak@linux.ibm.com>
References: <20211021152332.70455-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KPGXzP0tjDrwtp1l0t8-AnWcMdxrhoAh
X-Proofpoint-GUID: FPAYY4p409AFQxUCLi9FkLtftlT6K9Yq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_04,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Update the documentation in vfio-ap.rst to include information about the
AP dynamic configuration support (e.g., hot plug of adapters, domains
and control domains via the matrix mediated device's sysfs assignment
attributes). This patch also makes a few minor tweaks to make corrections
and clarifications.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 Documentation/s390/vfio-ap.rst | 492 +++++++++++++++++++++++----------
 1 file changed, 346 insertions(+), 146 deletions(-)

diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
index f57ae621f33e..f4b8748ab9a8 100644
--- a/Documentation/s390/vfio-ap.rst
+++ b/Documentation/s390/vfio-ap.rst
@@ -123,27 +123,24 @@ Let's now take a look at how AP instructions executed on a guest are interpreted
 by the hardware.
 
 A satellite control block called the Crypto Control Block (CRYCB) is attached to
-our main hardware virtualization control block. The CRYCB contains three fields
-to identify the adapters, usage domains and control domains assigned to the KVM
-guest:
+our main hardware virtualization control block. The CRYCB contains an AP Control
+Block (APCB) that has three fields to identify the adapters, usage domains and
+control domains assigned to the KVM guest:
 
 * The AP Mask (APM) field is a bit mask that identifies the AP adapters assigned
-  to the KVM guest. Each bit in the mask, from left to right (i.e. from most
-  significant to least significant bit in big endian order), corresponds to
+  to the KVM guest. Each bit in the mask, from left to right, corresponds to
   an APID from 0-255. If a bit is set, the corresponding adapter is valid for
   use by the KVM guest.
 
 * The AP Queue Mask (AQM) field is a bit mask identifying the AP usage domains
-  assigned to the KVM guest. Each bit in the mask, from left to right (i.e. from
-  most significant to least significant bit in big endian order), corresponds to
-  an AP queue index (APQI) from 0-255. If a bit is set, the corresponding queue
-  is valid for use by the KVM guest.
+  assigned to the KVM guest. Each bit in the mask, from left to right,
+  corresponds to an AP queue index (APQI) from 0-255. If a bit is set, the
+  corresponding queue is valid for use by the KVM guest.
 
 * The AP Domain Mask field is a bit mask that identifies the AP control domains
   assigned to the KVM guest. The ADM bit mask controls which domains can be
   changed by an AP command-request message sent to a usage domain from the
-  guest. Each bit in the mask, from left to right (i.e. from most significant to
-  least significant bit in big endian order), corresponds to a domain from
+  guest. Each bit in the mask, from left to right, corresponds to a domain from
   0-255. If a bit is set, the corresponding domain can be modified by an AP
   command-request message sent to a usage domain.
 
@@ -151,10 +148,10 @@ If you recall from the description of an AP Queue, AP instructions include
 an APQN to identify the AP queue to which an AP command-request message is to be
 sent (NQAP and PQAP instructions), or from which a command-reply message is to
 be received (DQAP instruction). The validity of an APQN is defined by the matrix
-calculated from the APM and AQM; it is the cross product of all assigned adapter
-numbers (APM) with all assigned queue indexes (AQM). For example, if adapters 1
-and 2 and usage domains 5 and 6 are assigned to a guest, the APQNs (1,5), (1,6),
-(2,5) and (2,6) will be valid for the guest.
+calculated from the APM and AQM; it is the Cartesian product of all assigned
+adapter numbers (APM) with all assigned queue indexes (AQM). For example, if
+adapters 1 and 2 and usage domains 5 and 6 are assigned to a guest, the APQNs
+(1,5), (1,6), (2,5) and (2,6) will be valid for the guest.
 
 The APQNs can provide secure key functionality - i.e., a private key is stored
 on the adapter card for each of its domains - so each APQN must be assigned to
@@ -192,7 +189,7 @@ The design introduces three new objects:
 
 1. AP matrix device
 2. VFIO AP device driver (vfio_ap.ko)
-3. VFIO AP mediated matrix pass-through device
+3. VFIO AP mediated pass-through device
 
 The VFIO AP device driver
 -------------------------
@@ -200,12 +197,13 @@ The VFIO AP (vfio_ap) device driver serves the following purposes:
 
 1. Provides the interfaces to secure APQNs for exclusive use of KVM guests.
 
-2. Sets up the VFIO mediated device interfaces to manage a mediated matrix
+2. Sets up the VFIO mediated device interfaces to manage a vfio_ap mediated
    device and creates the sysfs interfaces for assigning adapters, usage
    domains, and control domains comprising the matrix for a KVM guest.
 
-3. Configures the APM, AQM and ADM in the CRYCB referenced by a KVM guest's
-   SIE state description to grant the guest access to a matrix of AP devices
+3. Configures the APM, AQM and ADM in the APCB contained in the CRYCB referenced
+   by a KVM guest's SIE state description to grant the guest access to a matrix
+   of AP devices
 
 Reserve APQNs for exclusive use of KVM guests
 ---------------------------------------------
@@ -235,10 +233,10 @@ reserved::
   |                  |       8 probe        |                  |
   +--------^---------+                      +--^--^------------+
   6 edit   |                                   |  |
-    apmask |     +-----------------------------+  | 9 mdev create
+    apmask |     +-----------------------------+  | 11 mdev create
     aqmask |     |           1 modprobe           |
   +--------+-----+---+           +----------------+-+         +----------------+
-  |                  |           |                  |8 create |     mediated   |
+  |                  |           |                  |10 create|     mediated   |
   |      admin       |           | VFIO device core |--------->     matrix     |
   |                  +           |                  |         |     device     |
   +------+-+---------+           +--------^---------+         +--------^-------+
@@ -246,14 +244,14 @@ reserved::
 	 | | 9 create vfio_ap-passthrough |                            |
 	 | +------------------------------+                            |
 	 +-------------------------------------------------------------+
-		     10  assign adapter/domain/control domain
+		     12  assign adapter/domain/control domain
 
 The process for reserving an AP queue for use by a KVM guest is:
 
 1. The administrator loads the vfio_ap device driver
 2. The vfio-ap driver during its initialization will register a single 'matrix'
    device with the device core. This will serve as the parent device for
-   all mediated matrix devices used to configure an AP matrix for a guest.
+   all vfio_ap mediated devices used to configure an AP matrix for a guest.
 3. The /sys/devices/vfio_ap/matrix device is created by the device core
 4. The vfio_ap device driver will register with the AP bus for AP queue devices
    of type 10 and higher (CEX4 and newer). The driver will provide the vfio_ap
@@ -269,24 +267,24 @@ The process for reserving an AP queue for use by a KVM guest is:
    default zcrypt cex4queue driver.
 8. The AP bus probes the vfio_ap device driver to bind the queues reserved for
    it.
-9. The administrator creates a passthrough type mediated matrix device to be
+9. The administrator creates a passthrough type vfio_ap mediated device to be
    used by a guest
 10. The administrator assigns the adapters, usage domains and control domains
     to be exclusively used by a guest.
 
 Set up the VFIO mediated device interfaces
 ------------------------------------------
-The VFIO AP device driver utilizes the common interface of the VFIO mediated
+The VFIO AP device driver utilizes the common interfaces of the VFIO mediated
 device core driver to:
 
-* Register an AP mediated bus driver to add a mediated matrix device to and
+* Register an AP mediated bus driver to add a vfio_ap mediated device to and
   remove it from a VFIO group.
-* Create and destroy a mediated matrix device
-* Add a mediated matrix device to and remove it from the AP mediated bus driver
-* Add a mediated matrix device to and remove it from an IOMMU group
+* Create and destroy a vfio_ap mediated device
+* Add a vfio_ap mediated device to and remove it from the AP mediated bus driver
+* Add a vfio_ap mediated device to and remove it from an IOMMU group
 
 The following high-level block diagram shows the main components and interfaces
-of the VFIO AP mediated matrix device driver::
+of the VFIO AP mediated device driver::
 
    +-------------+
    |             |
@@ -343,7 +341,7 @@ matrix device.
 	* device_api:
 	    the mediated device type's API
 	* available_instances:
-	    the number of mediated matrix passthrough devices
+	    the number of vfio_ap mediated passthrough devices
 	    that can be created
 	* device_api:
 	    specifies the VFIO API
@@ -351,29 +349,37 @@ matrix device.
     This attribute group identifies the user-defined sysfs attributes of the
     mediated device. When a device is registered with the VFIO mediated device
     framework, the sysfs attribute files identified in the 'mdev_attr_groups'
-    structure will be created in the mediated matrix device's directory. The
-    sysfs attributes for a mediated matrix device are:
+    structure will be created in the vfio_ap mediated device's directory. The
+    sysfs attributes for a vfio_ap mediated device are:
 
     assign_adapter / unassign_adapter:
       Write-only attributes for assigning/unassigning an AP adapter to/from the
-      mediated matrix device. To assign/unassign an adapter, the APID of the
-      adapter is echoed to the respective attribute file.
+      vfio_ap mediated device. To assign/unassign an adapter, the APID of the
+      adapter is echoed into the respective attribute file.
     assign_domain / unassign_domain:
       Write-only attributes for assigning/unassigning an AP usage domain to/from
-      the mediated matrix device. To assign/unassign a domain, the domain
-      number of the usage domain is echoed to the respective attribute
+      the vfio_ap mediated device. To assign/unassign a domain, the domain
+      number of the usage domain is echoed into the respective attribute
       file.
     matrix:
-      A read-only file for displaying the APQNs derived from the cross product
-      of the adapter and domain numbers assigned to the mediated matrix device.
+      A read-only file for displaying the APQNs derived from the Cartesian
+      product of the adapter and domain numbers assigned to the vfio_ap mediated
+      device.
+    guest_matrix:
+      A read-only file for displaying the APQNs derived from the Cartesian
+      product of the adapter and domain numbers assigned to the APM and AQM
+      fields respectively of the KVM guest's CRYCB. This may differ from the
+      the APQNs assigned to the vfio_ap mediated device if any APQN does not
+      reference a queue device bound to the vfio_ap device driver (i.e., the
+      queue is not in the host's AP configuration).
     assign_control_domain / unassign_control_domain:
       Write-only attributes for assigning/unassigning an AP control domain
-      to/from the mediated matrix device. To assign/unassign a control domain,
-      the ID of the domain to be assigned/unassigned is echoed to the respective
-      attribute file.
+      to/from the vfio_ap mediated device. To assign/unassign a control domain,
+      the ID of the domain to be assigned/unassigned is echoed into the
+      respective attribute file.
     control_domains:
       A read-only file for displaying the control domain numbers assigned to the
-      mediated matrix device.
+      vfio_ap mediated device.
 
 * functions:
 
@@ -383,45 +389,75 @@ matrix device.
     * Store the reference to the KVM structure for the guest using the mdev
     * Store the AP matrix configuration for the adapters, domains, and control
       domains assigned via the corresponding sysfs attributes files
+    * Store the AP matrix configuration for the adapters, domains and control
+      domains available to a guest. A guest may not be provided access to APQNs
+      referencing queue devices that do not exist, or are not bound to the
+      vfio_ap device driver.
 
   remove:
-    deallocates the mediated matrix device's ap_matrix_mdev structure. This will
-    be allowed only if a running guest is not using the mdev.
+    deallocates the vfio_ap mediated device's ap_matrix_mdev structure.
+    This will be allowed only if a running guest is not using the mdev.
 
 * callback interfaces
 
-  open:
+  open_device:
     The vfio_ap driver uses this callback to register a
-    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the mdev matrix
-    device. The open is invoked when QEMU connects the VFIO iommu group
-    for the mdev matrix device to the MDEV bus. Access to the KVM structure used
-    to configure the KVM guest is provided via this callback. The KVM structure,
-    is used to configure the guest's access to the AP matrix defined via the
-    mediated matrix device's sysfs attribute files.
-  release:
+    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the matrix mdev
+    devices. The open_device callback is invoked by userspace to connect the
+    VFIO iommu group for the matrix mdev device to the MDEV bus. Access to the
+    KVM structure used to configure the KVM guest is provided via this callback.
+    The KVM structure, is used to configure the guest's access to the AP matrix
+    defined via the vfio_ap mediated device's sysfs attribute files.
+
+  close_device:
     unregisters the VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the
-    mdev matrix device and deconfigures the guest's AP matrix.
+    matrix mdev device and deconfigures the guest's AP matrix.
 
-Configure the APM, AQM and ADM in the CRYCB
--------------------------------------------
-Configuring the AP matrix for a KVM guest will be performed when the
+  ioctl:
+    this callback handles the VFIO_DEVICE_GET_INFO and VFIO_DEVICE_RESET ioctls
+    defined by the vfio framework.
+
+Configure the guest's AP resources
+----------------------------------
+Configuring the AP resources for a KVM guest will be performed when the
 VFIO_GROUP_NOTIFY_SET_KVM notifier callback is invoked. The notifier
-function is called when QEMU connects to KVM. The guest's AP matrix is
-configured via it's CRYCB by:
+function is called when userspace connects to KVM. The guest's AP resources are
+configured via it's APCB by:
 
 * Setting the bits in the APM corresponding to the APIDs assigned to the
-  mediated matrix device via its 'assign_adapter' interface.
+  vfio_ap mediated device via its 'assign_adapter' interface.
 * Setting the bits in the AQM corresponding to the domains assigned to the
-  mediated matrix device via its 'assign_domain' interface.
+  vfio_ap mediated device via its 'assign_domain' interface.
 * Setting the bits in the ADM corresponding to the domain dIDs assigned to the
-  mediated matrix device via its 'assign_control_domains' interface.
+  vfio_ap mediated device via its 'assign_control_domains' interface.
+
+The linux device model precludes passing a device through to a KVM guest that
+is not bound to the device driver facilitating its pass-through. Consequently,
+an APQN that does not reference a queue device bound to the vfio_ap device
+driver will not be assigned to a KVM guest's matrix. The AP architecture,
+however, does not provide a means to filter individual APQNs from the guest's
+matrix, so the adapters, domains and control domains assigned to vfio_ap
+mediated device via its sysfs 'assign_adapter', 'assign_domain' and
+'assign_control_domain' interfaces will be filtered before providing the AP
+configuration to a guest:
+
+* The APIDs of the adapters, the APQIs of the domains and the domain numbers of
+  the control domains assigned to the matrix mdev that are not also assigned to
+  the host's AP configuration will be filtered.
+
+* Each APQN derived from the Cartesian product of the APIDs and APQIs assigned
+  to the vfio_ap mdev is examined and if any one of them does not reference a
+  queue device bound to the vfio_ap device driver, the adapter will not be
+  plugged into the guest (i.e., the bit corresponding to its APID will not be
+  set in the APM of the guest's APCB).
 
 The CPU model features for AP
 -----------------------------
-The AP stack relies on the presence of the AP instructions as well as two
-facilities: The AP Facilities Test (APFT) facility; and the AP Query
-Configuration Information (QCI) facility. These features/facilities are made
-available to a KVM guest via the following CPU model features:
+The AP stack relies on the presence of the AP instructions as well as three
+facilities: The AP Facilities Test (APFT) facility; the AP Query
+Configuration Information (QCI) facility; and the AP Queue Interruption Control
+facility. These features/facilities are made available to a KVM guest via the
+following CPU model features:
 
 1. ap: Indicates whether the AP instructions are installed on the guest. This
    feature will be enabled by KVM only if the AP instructions are installed
@@ -435,24 +471,28 @@ available to a KVM guest via the following CPU model features:
    can be made available to the guest only if it is available on the host (i.e.,
    facility bit 12 is set).
 
+4. apqi: Indicates AP Queue Interruption Control faclity is available on the
+   guest. This facility can be made available to the guest only if it is
+   available on the host (i.e., facility bit 65 is set).
+
 Note: If the user chooses to specify a CPU model different than the 'host'
 model to QEMU, the CPU model features and facilities need to be turned on
 explicitly; for example::
 
-     /usr/bin/qemu-system-s390x ... -cpu z13,ap=on,apqci=on,apft=on
+     /usr/bin/qemu-system-s390x ... -cpu z13,ap=on,apqci=on,apft=on,apqi=on
 
 A guest can be precluded from using AP features/facilities by turning them off
 explicitly; for example::
 
-     /usr/bin/qemu-system-s390x ... -cpu host,ap=off,apqci=off,apft=off
+     /usr/bin/qemu-system-s390x ... -cpu host,ap=off,apqci=off,apft=off,apqi=off
 
 Note: If the APFT facility is turned off (apft=off) for the guest, the guest
-will not see any AP devices. The zcrypt device drivers that register for type 10
-and newer AP devices - i.e., the cex4card and cex4queue device drivers - need
-the APFT facility to ascertain the facilities installed on a given AP device. If
-the APFT facility is not installed on the guest, then the probe of device
-drivers will fail since only type 10 and newer devices can be configured for
-guest use.
+will not see any AP devices. The zcrypt device drivers on the guest that
+register for type 10 and newer AP devices - i.e., the cex4card and cex4queue
+device drivers - need the APFT facility to ascertain the facilities installed on
+a given AP device. If the APFT facility is not installed on the guest, then no
+adapter or domain devices will get created by the AP bus running on the
+guest because only type 10 and newer devices can be configured for guest use.
 
 Example
 =======
@@ -471,7 +511,7 @@ CARD.DOMAIN TYPE  MODE
 05.00ab     CEX5C CCA-Coproc
 06          CEX5A Accelerator
 06.0004     CEX5A Accelerator
-06.00ab     CEX5C CCA-Coproc
+06.00ab     CEX5A Accelerator
 =========== ===== ============
 
 Guest2
@@ -479,9 +519,9 @@ Guest2
 =========== ===== ============
 CARD.DOMAIN TYPE  MODE
 =========== ===== ============
-05          CEX5A Accelerator
-05.0047     CEX5A Accelerator
-05.00ff     CEX5A Accelerator
+05          CEX5C CCA-Coproc
+05.0047     CEX5C CCA-Coproc
+05.00ff     CEX5C CCA-Coproc
 =========== ===== ============
 
 Guest3
@@ -529,40 +569,56 @@ These are the steps:
 
 2. Secure the AP queues to be used by the three guests so that the host can not
    access them. To secure them, there are two sysfs files that specify
-   bitmasks marking a subset of the APQN range as 'usable by the default AP
-   queue device drivers' or 'not usable by the default device drivers' and thus
-   available for use by the vfio_ap device driver'. The location of the sysfs
-   files containing the masks are::
+   bitmasks marking a subset of the APQN range as usable only by the default AP
+   queue device drivers. All remaining APQNs are available for use by
+   any other device driver. The vfio_ap device driver is currently the only
+   non-default device driver. The location of the sysfs files containing the
+   masks are::
 
      /sys/bus/ap/apmask
      /sys/bus/ap/aqmask
 
    The 'apmask' is a 256-bit mask that identifies a set of AP adapter IDs
-   (APID). Each bit in the mask, from left to right (i.e., from most significant
-   to least significant bit in big endian order), corresponds to an APID from
-   0-255. If a bit is set, the APID is marked as usable only by the default AP
-   queue device drivers; otherwise, the APID is usable by the vfio_ap
-   device driver.
+   (APID). Each bit in the mask, from left to right, corresponds to an APID from
+   0-255. If a bit is set, the APID belongs to the subset of APQNs marked as
+   available only to the default AP queue device drivers.
 
    The 'aqmask' is a 256-bit mask that identifies a set of AP queue indexes
-   (APQI). Each bit in the mask, from left to right (i.e., from most significant
-   to least significant bit in big endian order), corresponds to an APQI from
-   0-255. If a bit is set, the APQI is marked as usable only by the default AP
-   queue device drivers; otherwise, the APQI is usable by the vfio_ap device
-   driver.
+   (APQI). Each bit in the mask, from left to right, corresponds to an APQI from
+   0-255. If a bit is set, the APQI belongs to the subset of APQNs marked as
+   available only to the default AP queue device drivers.
+
+   The Cartesian product of the APIDs corresponding to the bits set in the
+   apmask and the APQIs corresponding to the bits set in the aqmask comprise
+   the subset of APQNs that can be used only by the host default device drivers.
+   All other APQNs are available to the non-default device drivers such as the
+   vfio_ap driver.
+
+   Take, for example, the following masks::
+
+      apmask:
+      0x7d00000000000000000000000000000000000000000000000000000000000000
 
-   Take, for example, the following mask::
+      aqmask:
+      0x8000000000000000000000000000000000000000000000000000000000000000
 
-      0x7dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+   The masks indicate:
 
-    It indicates:
+   * Adapters 1, 2, 3, 4, 5, and 7 are available for use by the host default
+     device drivers.
 
-      1, 2, 3, 4, 5, and 7-255 belong to the default drivers' pool, and 0 and 6
-      belong to the vfio_ap device driver's pool.
+   * Domain 0 is available for use by the host default device drivers
+
+   * The subset of APQNs available for use only by the default host device
+     drivers are:
+
+     (1,0), (2,0), (3,0), (4.0), (5,0) and (7,0)
+
+   * All other APQNs are available for use by the non-default device drivers.
 
    The APQN of each AP queue device assigned to the linux host is checked by the
-   AP bus against the set of APQNs derived from the cross product of APIDs
-   and APQIs marked as usable only by the default AP queue device drivers. If a
+   AP bus against the set of APQNs derived from the Cartesian product of APIDs
+   and APQIs marked as available to the default AP queue device drivers. If a
    match is detected,  only the default AP queue device drivers will be probed;
    otherwise, the vfio_ap device driver will be probed.
 
@@ -579,8 +635,7 @@ These are the steps:
 
 	   0x4100000000000000000000000000000000000000000000000000000000000000
 
-	Keep in mind that the mask reads from left to right (i.e., most
-	significant to least significant bit in big endian order), so the mask
+	Keep in mind that the mask reads from left to right, so the mask
 	above identifies device numbers 1 and 7 (01000001).
 
 	If the string is longer than the mask, the operation is terminated with
@@ -626,11 +681,22 @@ These are the steps:
 	    default drivers pool:    adapter 0-15, domain 1
 	    alternate drivers pool:  adapter 16-255, domains 0, 2-255
 
+   Note ***:
+   Changing a mask such that one or more APQNs will be taken from a vfio_ap
+   mediated device (see below) will fail with an error (EBUSY). A message
+   is logged to the kernel ring buffer which can be viewed with the 'dmesg'
+   command. The output identifies each APQN flagged as 'in use' and identifies
+   the vfio_ap mediated device to which it is assigned; for example:
+
+   Userspace may not re-assign queue 05.0054 already assigned to 62177883-f1bb-47f0-914d-32a22e3a8804
+   Userspace may not re-assign queue 04.0054 already assigned to cef03c3c-903d-4ecc-9a83-40694cb8aee4
+
 Securing the APQNs for our example
 ----------------------------------
    To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004, 06.0047,
    06.00ab, and 06.00ff for use by the vfio_ap device driver, the corresponding
-   APQNs can either be removed from the default masks::
+   APQNs can be removed from the default masks using either of the following
+   commands::
 
       echo -5,-6 > /sys/bus/ap/apmask
 
@@ -683,7 +749,7 @@ Securing the APQNs for our example
 
      /sys/devices/vfio_ap/matrix/
      --- [mdev_supported_types]
-     ------ [vfio_ap-passthrough] (passthrough mediated matrix device type)
+     ------ [vfio_ap-passthrough] (passthrough vfio_ap mediated device type)
      --------- create
      --------- [devices]
 
@@ -734,6 +800,9 @@ Securing the APQNs for our example
      ----------------unassign_control_domain
      ----------------unassign_domain
 
+   Note *****: The vfio_ap mdevs do not persist across reboots unless the
+               mdevctl tool is used to create and persist them.
+
 4. The administrator now needs to configure the matrixes for the mediated
    devices $uuid1 (for Guest1), $uuid2 (for Guest2) and $uuid3 (for Guest3).
 
@@ -755,6 +824,10 @@ Securing the APQNs for our example
 
 	 cat matrix
 
+   To display the matrix that is or will be assigned to Guest1::
+
+	 cat guest_matrix
+
    This is how the matrix is configured for Guest2::
 
       echo 5 > assign_adapter
@@ -774,17 +847,24 @@ Securing the APQNs for our example
      higher than the maximum is specified, the operation will terminate with
      an error (ENODEV).
 
-   * All APQNs that can be derived from the adapter ID and the IDs of
-     the previously assigned domains must be bound to the vfio_ap device
-     driver. If no domains have yet been assigned, then there must be at least
-     one APQN with the specified APID bound to the vfio_ap driver. If no such
-     APQNs are bound to the driver, the operation will terminate with an
-     error (EADDRNOTAVAIL).
+     Note: The maximum adapter number can be obtained via the sysfs
+	   /sys/bus/ap/ap_max_adapter_id attribute file.
+
+   * Each APQN derived from the Cartesian product of the APID of the adapter
+     being assigned and the APQIs of the domains previously assigned:
 
-     No APQN that can be derived from the adapter ID and the IDs of the
-     previously assigned domains can be assigned to another mediated matrix
-     device. If an APQN is assigned to another mediated matrix device, the
-     operation will terminate with an error (EADDRINUSE).
+     - Must only be available to the vfio_ap device driver as specified in the
+       sysfs /sys/bus/ap/apmask and /sys/bus/ap/aqmask attribute files. If even
+       one APQN is reserved for use by the host device driver, the operation
+       will terminate with an error (EADDRNOTAVAIL).
+
+     - Must NOT be assigned to another vfio_ap mediated device. If even one APQN
+       is assigned to another vfio_ap mediated device, the operation will
+       terminate with an error (EBUSY).
+
+     - Must NOT be assigned while the sysfs /sys/bus/ap/apmask and
+       sys/bus/ap/aqmask attribute files are being edited or the operation may
+       terminate with an error (EBUSY).
 
    In order to successfully assign a domain:
 
@@ -793,41 +873,50 @@ Securing the APQNs for our example
      higher than the maximum is specified, the operation will terminate with
      an error (ENODEV).
 
-   * All APQNs that can be derived from the domain ID and the IDs of
-     the previously assigned adapters must be bound to the vfio_ap device
-     driver. If no domains have yet been assigned, then there must be at least
-     one APQN with the specified APQI bound to the vfio_ap driver. If no such
-     APQNs are bound to the driver, the operation will terminate with an
-     error (EADDRNOTAVAIL).
+     Note: The maximum domain number can be obtained via the sysfs
+	   /sys/bus/ap/ap_max_domain_id attribute file.
+
+    * Each APQN derived from the Cartesian product of the APQI of the domain
+      being assigned and the APIDs of the adapters previously assigned:
 
-     No APQN that can be derived from the domain ID and the IDs of the
-     previously assigned adapters can be assigned to another mediated matrix
-     device. If an APQN is assigned to another mediated matrix device, the
-     operation will terminate with an error (EADDRINUSE).
+     - Must only be available to the vfio_ap device driver as specified in the
+       sysfs /sys/bus/ap/apmask and /sys/bus/ap/aqmask attribute files. If even
+       one APQN is reserved for use by the host device driver, the operation
+       will terminate with an error (EADDRNOTAVAIL).
 
-   In order to successfully assign a control domain, the domain number
-   specified must represent a value from 0 up to the maximum domain number
-   configured for the system. If a control domain number higher than the maximum
-   is specified, the operation will terminate with an error (ENODEV).
+     - Must NOT be assigned to another vfio_ap mediated device. If even one APQN
+       is assigned to another vfio_ap mediated device, the operation will
+       terminate with an error (EBUSY).
+
+     - Must NOT be assigned while the sysfs /sys/bus/ap/apmask and
+       sys/bus/ap/aqmask attribute files are being edited or the operation may
+       terminate with an error (EBUSY).
+
+   In order to successfully assign a control domain:
+
+   * The domain number specified must represent a value from 0 up to the maximum
+     domain number configured for the system. If a control domain number higher
+     than the maximum is specified, the operation will terminate with an
+     error (ENODEV).
 
 5. Start Guest1::
 
-     /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on \
+     /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on,apqi=on \
 	-device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid1 ...
 
 7. Start Guest2::
 
-     /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on \
+     /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on,apqi=on \
 	-device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid2 ...
 
 7. Start Guest3::
 
-     /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on \
+     /usr/bin/qemu-system-s390x ... -cpu host,ap=on,apqci=on,apft=on,apqi=on \
 	-device vfio-ap,sysfsdev=/sys/devices/vfio_ap/matrix/$uuid3 ...
 
-When the guest is shut down, the mediated matrix devices may be removed.
+When the guest is shut down, the vfio_ap mediated devices may be removed.
 
-Using our example again, to remove the mediated matrix device $uuid1::
+Using our example again, to remove the vfio_ap mediated device $uuid1::
 
    /sys/devices/vfio_ap/matrix/
       --- [mdev_supported_types]
@@ -840,26 +929,137 @@ Using our example again, to remove the mediated matrix device $uuid1::
 
    echo 1 > remove
 
-This will remove all of the mdev matrix device's sysfs structures including
-the mdev device itself. To recreate and reconfigure the mdev matrix device,
+This will remove all of the matrix mdev device's sysfs structures including
+the mdev device itself. To recreate and reconfigure the matrix mdev device,
 all of the steps starting with step 3 will have to be performed again. Note
-that the remove will fail if a guest using the mdev is still running.
+that the remove will fail if a guest using the vfio_ap mdev is still running.
 
-It is not necessary to remove an mdev matrix device, but one may want to
+It is not necessary to remove a vfio_ap mdev, but one may want to
 remove it if no guest will use it during the remaining lifetime of the linux
-host. If the mdev matrix device is removed, one may want to also reconfigure
+host. If the vfio_ap mdev is removed, one may want to also reconfigure
 the pool of adapters and queues reserved for use by the default drivers.
 
+Hot plug/unplug support:
+================
+An adapter, domain or control domain may be hot plugged into a running KVM
+guest by assigning it to the vfio_ap mediated device being used by the guest if
+the following conditions are met:
+
+* The adapter, domain or control domain must also be assigned to the host's
+  AP configuration.
+
+* Each APQN derived from the Cartesian product comprised of the APID of the
+  adapter being assigned and the APQIs of the domains assigned must reference a
+  queue device bound to the vfio_ap device driver.
+
+* To hot plug a domain, each APQN derived from the Cartesian product
+  comprised of the APQI of the domain being assigned and the APIDs of the
+  adapters assigned must reference a queue device bound to the vfio_ap device
+  driver.
+
+An adapter, domain or control domain may be hot unplugged from a running KVM
+guest by unassigning it from the vfio_ap mediated device being used by the
+guest.
+
+Over-provisioning of AP queues for a KVM guest:
+==============================================
+Over-provisioning is defined herein as the assignment of adapters or domains to
+a vfio_ap mediated device that do not reference AP devices in the host's AP
+configuration. The idea here is that when the adapter or domain becomes
+available, it will be automatically hot-plugged into the KVM guest using
+the vfio_ap mediated device to which it is assigned as long as each new APQN
+resulting from plugging it in references a queue device bound to the vfio_ap
+device driver.
+
 Limitations
 ===========
-* The KVM/kernel interfaces do not provide a way to prevent restoring an APQN
-  to the default drivers pool of a queue that is still assigned to a mediated
-  device in use by a guest. It is incumbent upon the administrator to
-  ensure there is no mediated device in use by a guest to which the APQN is
-  assigned lest the host be given access to the private data of the AP queue
-  device such as a private key configured specifically for the guest.
+Live guest migration is not supported for guests using AP devices without
+intervention by a system administrator. Before a KVM guest can be migrated,
+the vfio_ap mediated device must be removed. Unfortunately, it can not be
+removed manually (i.e., echo 1 > /sys/devices/vfio_ap/matrix/$UUID/remove) while
+the mdev is in use by a KVM guest. If the guest is being emulated by QEMU,
+its mdev can be hot unplugged from the guest in one of two ways:
+
+1. If the KVM guest was started with libvirt, you can hot unplug the mdev via
+   the following commands:
+
+      virsh detach-device <guestname> <path-to-device-xml>
+
+      For example, to hot unplug mdev 62177883-f1bb-47f0-914d-32a22e3a8804 from
+      the guest named 'my-guest':
+
+         virsh detach-device my-guest ~/config/my-guest-hostdev.xml
+
+            The contents of my-guest-hostdev.xml:
+
+            <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-ap'>
+              <source>
+                <address uuid='62177883-f1bb-47f0-914d-32a22e3a8804'/>
+              </source>
+            </hostdev>
+
+
+      virsh qemu-monitor-command <guest-name> --hmp "device-del <device-id>"
+
+      For example, to hot unplug the vfio_ap mediated device identified on the
+      qemu command line with 'id=hostdev0' from the guest named 'my-guest':
+
+         virsh qemu-monitor-command my-guest --hmp "device_del hostdev0"
+
+2. A vfio_ap mediated device can be hot unplugged by attaching the qemu monitor
+   to the guest and using the following qemu monitor command:
+
+      (QEMU) device-del id=<device-id>
+
+      For example, to hot unplug the vfio_ap mediated device that was specified
+      on the qemu command line with 'id=hostdev0' when the guest was started:
+
+         (QEMU) device-del id=hostdev0
+
+After live migration of the KVM guest completes, an AP configuration can be
+restored to the KVM guest by hot plugging a vfio_ap mediated device on the target
+system into the guest in one of two ways:
+
+1. If the KVM guest was started with libvirt, you can hot plug a matrix mediated
+   device into the guest via the following virsh commands:
+
+   virsh attach-device <guestname> <path-to-device-xml>
+
+      For example, to hot plug mdev 62177883-f1bb-47f0-914d-32a22e3a8804 into
+      the guest named 'my-guest':
+
+         virsh attach-device my-guest ~/config/my-guest-hostdev.xml
+
+            The contents of my-guest-hostdev.xml:
+
+            <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-ap'>
+              <source>
+                <address uuid='62177883-f1bb-47f0-914d-32a22e3a8804'/>
+              </source>
+            </hostdev>
+
+
+   virsh qemu-monitor-command <guest-name> --hmp \
+   "device_add vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
+
+      For example, to hot plug the vfio_ap mediated device
+      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest named 'my-guest' with
+      device-id hostdev0:
+
+      virsh qemu-monitor-command my-guest --hmp \
+      "device_add vfio-ap,\
+      sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
+      id=hostdev0"
+
+2. A vfio_ap mediated device can be hot plugged by attaching the qemu monitor
+   to the guest and using the following qemu monitor command:
+
+      (qemu) device_add "vfio-ap,sysfsdev=<path-to-mdev>,id=<device-id>"
 
-* Dynamically modifying the AP matrix for a running guest (which would amount to
-  hot(un)plug of AP devices for the guest) is currently not supported
+      For example, to plug the vfio_ap mediated device
+      62177883-f1bb-47f0-914d-32a22e3a8804 into the guest with the device-id
+      hostdev0:
 
-* Live guest migration is not supported for guests using AP devices.
+         (QEMU) device-add "vfio-ap,\
+         sysfsdev=/sys/devices/vfio_ap/matrix/62177883-f1bb-47f0-914d-32a22e3a8804,\
+         id=hostdev0"
-- 
2.31.1

