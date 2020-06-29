Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3D20D12A
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2020 20:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgF2SjJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 29 Jun 2020 14:39:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgF2SjI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jun 2020 14:39:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TF4GkT152437;
        Mon, 29 Jun 2020 11:11:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31y3xchch9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 11:11:48 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TF4F1K152427;
        Mon, 29 Jun 2020 11:11:48 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31y3xchcgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 11:11:47 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TFAQeO029112;
        Mon, 29 Jun 2020 15:11:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 31wwr8887p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 15:11:46 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TFBiQT33882436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 15:11:44 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D637F124053;
        Mon, 29 Jun 2020 15:11:44 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B3A0124052;
        Mon, 29 Jun 2020 15:11:44 +0000 (GMT)
Received: from cpe-172-100-175-116.stny.res.rr.com (unknown [9.85.160.4])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jun 2020 15:11:44 +0000 (GMT)
Subject: Re: [PATCH v8 00/16] s390/vfio-ap: dynamic configuration support
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com
References: <20200605214004.14270-1-akrowiak@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <b6c60eff-3f8f-3e35-df52-11f6fb95cc4a@linux.ibm.com>
Date:   Mon, 29 Jun 2020 11:11:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605214004.14270-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_15:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=3
 cotscore=-2147483648 clxscore=1011 impostorscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006290103
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This series has been on the mailing list since June 5th. It would be GREATLY
appreciated if these patches can get some attention so we can move
forward with providing dynamic Adjunct Processor configuration support for
our customers. Thanks in advance for your time.

On 6/5/20 5:39 PM, Tony Krowiak wrote:
> Note: Patch 1 - s390/ap: introduce new ap function ap_get_qdev() - is not
>        a part of this series. It is a forthcoming patch that is a
>        prerequisite to this series and is being provided so this series
>        will compile.
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
> 1. A root user will be prevented from making changes to the AP bus's
>     /sys/bus/ap/apmask or /sys/bus/ap/aqmask if the ownership of an APQN
>     changes from the vfio_ap device driver to a zcrypt driver when the
>     APQN is assigned to a matrix mdev.
>
> 2. Allow a root user to hot plug/unplug AP adapters, domains and control
>     domains using the matrix mdev's assign/unassign attributes.
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
> Harald Freudenberger (2):
>    s390/ap: introduce new ap function ap_get_qdev()
>    s390/zcrypt: Notify driver on config changed and scan complete
>      callbacks
>
> Tony Krowiak (14):
>    s390/vfio-ap: use new AP bus interface to search for queue devices
>    s390/vfio-ap: manage link between queue struct and matrix mdev
>    s390/zcrypt: driver callback to indicate resource in use
>    s390/vfio-ap: implement in-use callback for vfio_ap driver
>    s390/vfio-ap: introduce shadow APCB
>    s390/vfio-ap: sysfs attribute to display the guest's matrix
>    s390/vfio-ap: filter matrix for unavailable queue devices
>    s390/vfio_ap: add qlink from ap_matrix_mdev struct to vfio_ap_queue
>      struct
>    s390/vfio-ap: allow assignment of unavailable AP queues to mdev device
>    s390/vfio-ap: allow configuration of matrix mdev in use by a KVM guest
>    s390/vfio-ap: allow hot plug/unplug of AP resources using mdev device
>    s390/vfio-ap: handle host AP config change notification
>    s390/vfio-ap: handle AP bus scan completed notification
>    s390/vfio-ap: handle probe/remove not due to host AP config changes
>
>   drivers/s390/crypto/ap_bus.c          |  417 +++++++--
>   drivers/s390/crypto/ap_bus.h          |   41 +-
>   drivers/s390/crypto/ap_card.c         |   47 +-
>   drivers/s390/crypto/ap_queue.c        |   10 +-
>   drivers/s390/crypto/vfio_ap_drv.c     |   34 +-
>   drivers/s390/crypto/vfio_ap_ops.c     | 1165 ++++++++++++++++++++-----
>   drivers/s390/crypto/vfio_ap_private.h |   23 +-
>   7 files changed, 1339 insertions(+), 398 deletions(-)
>

