Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F882EC037
	for <lists+linux-s390@lfdr.de>; Wed,  6 Jan 2021 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbhAFPRP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 Jan 2021 10:17:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbhAFPRP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Jan 2021 10:17:15 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 106F2qQM187773;
        Wed, 6 Jan 2021 10:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4aGEOBxLsuotCaOpNi0aginj+XCMay5we6BJyVaBi7A=;
 b=fSr9l+eXbRK5aelw7ADNAnFCLO6FWzrnSozzy/lGXMS8Kad6R8IzJeeNfBs/UNTczrsO
 sjyRC7h6G5il94QqiBmGXiE3fAQsXrhhXCRnCs+Hw2Ybd216KaHfzUPs2SYTvh+f4IWd
 cRMLMYE6RL7Agz1cg0vqmjsmjCioMx8zpdIbp8pkQb7Z0J49+iPiAuFds0F68ys4Qrsx
 awjmn3U3Tki6SGUesmRm5OPYVp45pTVbZDrIES45yOGqh97Wzj1UfQB0W02YpKOZ1q+7
 sZp8m3CSQzjHOb/2iHRc3ETmV9rlYZbV9vvYD9QGQQ4QCRWVseTYnj8O+QBh2WGgnJyj /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35wexq1h5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 10:16:32 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 106F2D1S184932;
        Wed, 6 Jan 2021 10:16:32 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35wexq1h4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 10:16:31 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 106FBck1014531;
        Wed, 6 Jan 2021 15:16:31 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 35tgf9n44c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 15:16:30 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 106FGReO11207004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jan 2021 15:16:27 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AA54C6059;
        Wed,  6 Jan 2021 15:16:27 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50DFCC6055;
        Wed,  6 Jan 2021 15:16:25 +0000 (GMT)
Received: from cpe-66-24-58-13.stny.res.rr.com (unknown [9.85.193.150])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jan 2021 15:16:25 +0000 (GMT)
Subject: Re: [PATCH v13 00/15] s390/vfio-ap: dynamic configuration support
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        hca@linux.ibm.com, gor@linux.ibm.com
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <3c350e32-3206-25cb-1b1e-6577e8c15ae2@linux.ibm.com>
Date:   Wed, 6 Jan 2021 10:16:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201223011606.5265-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_06:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060091
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Ping

On 12/22/20 8:15 PM, Tony Krowiak wrote:
> Note: Patch 1, s390/vfio-ap: clean up vfio_ap resources when KVM
>        pointer invalidated does not belong to this series. It has been
>        posted as a separate patch to fix a known problem. It is included
>        here because it will likely pre-req for this series.
>
> The current design for AP pass-through does not support making dynamic
> changes to the AP matrix of a running guest resulting in a few
> deficiencies this patch series is intended to mitigate:
>
> 1. Adapters, domains and control domains can not be added to or removed
>     from a running guest. In order to modify a guest's AP configuration,
>     the guest must be terminated; only then can AP resources be assigned
>     to or unassigned from the guest's matrix mdev. The new AP
>     configuration becomes available to the guest when it is subsequently
>     restarted.
>
> 2. The AP bus's /sys/bus/ap/apmask and /sys/bus/ap/aqmask interfaces can
>     be modified by a root user without any restrictions. A change to
>     either mask can result in AP queue devices being unbound from the
>     vfio_ap device driver and bound to a zcrypt device driver even if a
>     guest is using the queues, thus giving the host access to the guest's
>     private crypto data and vice versa.
>
> 3. The APQNs derived from the Cartesian product of the APIDs of the
>     adapters and APQIs of the domains assigned to a matrix mdev must
>     reference an AP queue device bound to the vfio_ap device driver. The
>     AP architecture allows assignment of AP resources that are not
>     available to the system, so this artificial restriction is not
>     compliant with the architecture.
>
> 4. The AP configuration profile can be dynamically changed for the linux
>     host after a KVM guest is started. For example, a new domain can be
>     dynamically added to the configuration profile via the SE or an HMC
>     connected to a DPM enabled lpar. Likewise, AP adapters can be
>     dynamically configured (online state) and deconfigured (standby state)
>     using the SE, an SCLP command or an HMC connected to a DPM enabled
>     lpar. This can result in inadvertent sharing of AP queues between the
>     guest and host.
>
> 5. A root user can manually unbind an AP queue device representing a
>     queue in use by a KVM guest via the vfio_ap device driver's sysfs
>     unbind attribute. In this case, the guest will be using a queue that
>     is not bound to the driver which violates the device model.
>
> This patch series introduces the following changes to the current design
> to alleviate the shortcomings described above as well as to implement
> more of the AP architecture:
>
> 1. A root user will be prevented from making edits to the AP bus's
>     /sys/bus/ap/apmask or /sys/bus/ap/aqmask if the change would transfer
>     ownership of an APQN from the vfio_ap device driver to a zcrypt driver
>     while the APQN is assigned to a matrix mdev.
>
> 2. Allow a root user to hot plug/unplug AP adapters, domains and control
>     domains for a KVM guest using the matrix mdev via its sysfs
>     assign/unassign attributes.
>
> 4. Allow assignment of an AP adapter or domain to a matrix mdev even if
>     it results in assignment of an APQN that does not reference an AP
>     queue device bound to the vfio_ap device driver, as long as the APQN
>     is not reserved for use by the default zcrypt drivers (also known as
>     over-provisioning of AP resources). Allowing over-provisioning of AP
>     resources better models the architecture which does not preclude
>     assigning AP resources that are not yet available in the system. Such
>     APQNs, however, will not be assigned to the guest using the matrix
>     mdev; only APQNs referencing AP queue devices bound to the vfio_ap
>     device driver will actually get assigned to the guest.
>
> 5. Handle dynamic changes to the AP device model.
>
> 1. Rationale for changes to AP bus's apmask/aqmask interfaces:
> ----------------------------------------------------------
> Due to the extremely sensitive nature of cryptographic data, it is
> imperative that great care be taken to ensure that such data is secured.
> Allowing a root user, either inadvertently or maliciously, to configure
> these masks such that a queue is shared between the host and a guest is
> not only avoidable, it is advisable. It was suggested that this scenario
> is better handled in user space with management software, but that does
> not preclude a malicious administrator from using the sysfs interfaces
> to gain access to a guest's crypto data. It was also suggested that this
> scenario could be avoided by taking access to the adapter away from the
> guest and zeroing out the queues prior to the vfio_ap driver releasing the
> device; however, stealing an adapter in use from a guest as a by-product
> of an operation is bad and will likely cause problems for the guest
> unnecessarily. It was decided that the most effective solution with the
> least number of negative side effects is to prevent the situation at the
> source.
>
> 2. Rationale for hot plug/unplug using matrix mdev sysfs interfaces:
> ----------------------------------------------------------------
> Allowing a user to hot plug/unplug AP resources using the matrix mdev
> sysfs interfaces circumvents the need to terminate the guest in order to
> modify its AP configuration. Allowing dynamic configuration makes
> reconfiguring a guest's AP matrix much less disruptive.
>
> 3. Rationale for allowing over-provisioning of AP resources:
> -----------------------------------------------------------
> Allowing assignment of AP resources to a matrix mdev and ultimately to a
> guest better models the AP architecture. The architecture does not
> preclude assignment of unavailable AP resources. If a queue subsequently
> becomes available while a guest using the matrix mdev to which its APQN
> is assigned, the guest will be given access to it. If an APQN
> is dynamically unassigned from the underlying host system, it will
> automatically become unavailable to the guest.
>
> Change log v12-v13:
> ------------------
> * Combined patches 12/13 from previous series into one patch
>
> * Moved all changes for linking queues and mdevs into a single patch
>
> * Re-ordered some patches to aid in review
>
> * Using mutex_trylock() function in adapter/domain assignment functions
>    to avoid potential deadlock condition with in_use callback
>
> * Using filtering function for refreshing the guest's APCB for all events
>    that change the APCB: assign/unassign adapters, domains, control domains;
>    bind/unbind of queue devices; and, changes to the host AP configuration.
>
> Change log v11-v12:
> ------------------
> * Moved matrix device lock to protect group notifier callback
>
> * Split the 'No need to disable IRQ after queue reset' patch into
>    multiple patches for easier review (move probe/remove callback
>    functions and remove disable IRQ after queue reset)
>
> * Added code to decrement reference count for KVM in group notifier
>    callback
>
> * Using mutex_trylock() in functions implementing the sysfs assign_adapter
>    and assign_domain as well as the in_use callback to avoid deadlock
>    between the AP bus's ap_perms mutex and the matrix device lock used by
>    vfio_ap driver.
>
> * The sysfs guest_matrix attribute of the vfio_ap mdev will now display
>    the shadow APCB regardless of whether a guest is using the mdev or not
>
> * Replaced vfio_ap mdev filtering function with a function that initializes
>    the guest's APCB by filtering the vfio_ap mdev by APID.
>
> * No longer using filtering function during adapter/domain assignment
>    to/from the vfio_ap mdev; replaced with new hot plug/unplug
>    adapter/domain functions.
>
> * No longer using filtering function during bind/unbind; replaced with
>    hot plug/unplug queue functions.
>
> * No longer using filtering function for bulk assignment of new adapters
>    and domains in on_scan_complete callback; replaced with new hot plug
>    functions.
>    
>
> Change log v10-v11:
> ------------------
> * The matrix mdev's configuration is not filtered by APID so that if any
>    APQN assigned to the mdev is not bound to the vfio_ap device driver,
>    the adapter will not get plugged into the KVM guest on startup, or when
>    a new adapter is assigned to the mdev.
>
> * Replaced patch 8 by squashing patches 8 (filtering patch) and 15 (handle
>    probe/remove).
>
> * Added a patch 1 to remove disable IRQ after a reset because the reset
>    already disables a queue.
>
> * Now using filtering code to update the KVM guest's matrix when
>    notified that AP bus scan has completed.
>
> * Fixed issue with probe/remove not inititiated by a configuration change
>    occurring within a config change.
>
>
> Change log v9-v10:
> -----------------
> * Updated the documentation in vfio-ap.rst to include information about the
>    AP dynamic configuration support
>
> Change log v8-v9:
> ----------------
> * Fixed errors flagged by the kernel test robot
>
> * Fixed issue with guest losing queues when a new queue is probed due to
>    manual bind operation.
>
> Change log v7-v8:
> ----------------
> * Now logging a message when an attempt to reserve APQNs for the zcrypt
>    drivers will result in taking a queue away from a KVM guest to provide
>    the sysadmin a way to ascertain why the sysfs operation failed.
>
> * Created locked and unlocked versions of the ap_parse_mask_str() function.
>
> * Now using new interface provided by an AP bus patch -
>    s390/ap: introduce new ap function ap_get_qdev() - to retrieve
>    struct ap_queue representing an AP queue device. This patch is not a
>    part of this series but is a prerequisite for this series.
>
> Change log v6-v7:
> ----------------
> * Added callbacks to AP bus:
>    - on_config_changed: Notifies implementing drivers that
>      the AP configuration has changed since last AP device scan.
>    - on_scan_complete: Notifies implementing drivers that the device scan
>      has completed.
>    - implemented on_config_changed and on_scan_complete callbacks for
>      vfio_ap device driver.
>    - updated vfio_ap device driver's probe and remove callbacks to handle
>      dynamic changes to the AP device model.
> * Added code to filter APQNs when assigning AP resources to a KVM guest's
>    CRYCB
>
> Change log v5-v6:
> ----------------
> * Fixed a bug in ap_bus.c introduced with patch 2/7 of the v5
>    series. Harald Freudenberer pointed out that the mutex lock
>    for ap_perms_mutex in the apmask_store and aqmask_store functions
>    was not being freed.
>
> * Removed patch 6/7 which added logging to the vfio_ap driver
>    to expedite acceptance of this series. The logging will be introduced
>    with a separate patch series to allow more time to explore options
>    such as DBF logging vs. tracepoints.
>
> * Added 3 patches related to ensuring that APQNs that do not reference
>    AP queue devices bound to the vfio_ap device driver are not assigned
>    to the guest CRYCB:
>
>    Patch 4: Filter CRYCB bits for unavailable queue devices
>    Patch 5: sysfs attribute to display the guest CRYCB
>    Patch 6: update guest CRYCB in vfio_ap probe and remove callbacks
>
> * Added a patch (Patch 9) to version the vfio_ap module.
>
> * Reshuffled patches to allow the in_use callback implementation to
>    invoke the vfio_ap_mdev_verify_no_sharing() function introduced in
>    patch 2.
>
> Change log v4-v5:
> ----------------
> * Added a patch to provide kernel s390dbf debug logs for VFIO AP
>
> Change log v3->v4:
> -----------------
> * Restored patches preventing root user from changing ownership of
>    APQNs from zcrypt drivers to the vfio_ap driver if the APQN is
>    assigned to an mdev.
>
> * No longer enforcing requirement restricting guest access to
>    queues represented by a queue device bound to the vfio_ap
>    device driver.
>
> * Removed shadow CRYCB and now directly updating the guest CRYCB
>    from the matrix mdev's matrix.
>
> * Rebased the patch series on top of 'vfio: ap: AP Queue Interrupt
>    Control' patches.
>
> * Disabled bind/unbind sysfs interfaces for vfio_ap driver
>
> Change log v2->v3:
> -----------------
> * Allow guest access to an AP queue only if the queue is bound to
>    the vfio_ap device driver.
>
> * Removed the patch to test CRYCB masks before taking the vCPUs
>    out of SIE. Now checking the shadow CRYCB in the vfio_ap driver.
>
> Change log v1->v2:
> -----------------
> * Removed patches preventing root user from unbinding AP queues from
>    the vfio_ap device driver
> * Introduced a shadow CRYCB in the vfio_ap driver to manage dynamic
>    changes to the AP guest configuration due to root user interventions
>    or hardware anomalies.
>
> Tony Krowiak (15):
>    s390/vfio-ap: clean up vfio_ap resources when KVM pointer invalidated
>    s390/vfio-ap: No need to disable IRQ after queue reset
>    s390/vfio-ap: move probe and remove callbacks to vfio_ap_ops.c
>    s390/vfio-ap: use new AP bus interface to search for queue devices
>    s390/vfio-ap: manage link between queue struct and matrix mdev
>    s390/vfio-ap: allow assignment of unavailable AP queues to mdev device
>    s390/vfio-ap: introduce shadow APCB
>    s390/vfio-ap: sysfs attribute to display the guest's matrix
>    s390/vfio-ap: allow hot plug/unplug of AP resources using mdev device
>    s390/zcrypt: driver callback to indicate resource in use
>    s390/vfio-ap: implement in-use callback for vfio_ap driver
>    s390/zcrypt: Notify driver on config changed and scan complete
>      callbacks
>    s390/vfio-ap: handle host AP config change notification
>    s390/vfio-ap: handle AP bus scan completed notification
>    s390/vfio-ap: update docs to include dynamic config support
>
>   Documentation/s390/vfio-ap.rst        | 383 ++++++++---
>   drivers/s390/crypto/ap_bus.c          | 251 +++++++-
>   drivers/s390/crypto/ap_bus.h          |  16 +
>   drivers/s390/crypto/vfio_ap_drv.c     |  50 +-
>   drivers/s390/crypto/vfio_ap_ops.c     | 891 +++++++++++++++++---------
>   drivers/s390/crypto/vfio_ap_private.h |  29 +-
>   6 files changed, 1170 insertions(+), 450 deletions(-)
>

