Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022DB611824
	for <lists+linux-s390@lfdr.de>; Fri, 28 Oct 2022 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJ1Qvq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 28 Oct 2022 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiJ1Qvi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Oct 2022 12:51:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDECFDB772;
        Fri, 28 Oct 2022 09:51:37 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SGneGV007403;
        Fri, 28 Oct 2022 16:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hdQXFOJ4gLXb6ELjexr+d087autOfdKdbtTk1+bmeL0=;
 b=cGFEj7tyI+DRYFBV+DTU1SPsO3RKlwDlP1wzTCxAL5vsk0v02yQyga2IJSpjAyeLE57q
 1XLjUPeWdptzIKoXN9BBNFEQ7at/A8b142/MDDsVRH4k0xDIMAWpeihwDFPF1i09Na4p
 X7LIrXloDfUVaXC9O4VGnqoqHbMzDeGFjeBRpSX9GFNfVVjnkXnPi3idsb2X7ylP82d/
 MLD1VDH1VISOqu9eAmog6Esgs6OaN9GwoTaCm4NI2lpVkXCnfGraeTqYtjwMGHlQis9+
 swFpLGCw5JedD3WJnkD7yJgV4Cg8NBqS02DAxQrT1XauW03N0WaFyaOLvp5Awz8cD6Ui Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgjxr00s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:51:09 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29SGp84d011659;
        Fri, 28 Oct 2022 16:51:09 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgjxr00rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:51:08 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SGZT1I032199;
        Fri, 28 Oct 2022 16:51:07 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3kfah2n85r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:51:07 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SGp51J61800734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 16:51:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 789CA58062;
        Fri, 28 Oct 2022 16:51:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0C3858066;
        Fri, 28 Oct 2022 16:51:00 +0000 (GMT)
Received: from [9.160.93.208] (unknown [9.160.93.208])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 16:51:00 +0000 (GMT)
Message-ID: <471d1f18-13b5-8e80-32aa-1598bca5bf2e@linux.ibm.com>
Date:   Fri, 28 Oct 2022 12:51:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 1/7] vfio/ccw: create a parent struct
Content-Language: en-US
To:     Eric Farman <farman@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
References: <20221019162135.798901-1-farman@linux.ibm.com>
 <20221019162135.798901-2-farman@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221019162135.798901-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0YmIHF-jUowLAQz3LBBWejEL6rJtIM06
X-Proofpoint-GUID: ClKqJpmsIGCr0M3tkrmhUgbZG4xlwYnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=955 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/19/22 12:21 PM, Eric Farman wrote:
> Move the stuff associated with the mdev parent (and thus the
> subchannel struct) into its own struct, and leave the rest in
> the existing private structure.
> 
> The subchannel will point to the parent, and the parent will point
> to the private, for the areas where one or both are needed. Further
> separation of these structs will follow.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 104 ++++++++++++++++++++--------
>  drivers/s390/cio/vfio_ccw_ops.c     |   9 ++-
>  drivers/s390/cio/vfio_ccw_parent.h  |  28 ++++++++
>  drivers/s390/cio/vfio_ccw_private.h |   5 --
>  4 files changed, 112 insertions(+), 34 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_parent.h
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 7f5402fe857a..634760ca0dea 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -20,6 +20,7 @@
>  #include "chp.h"
>  #include "ioasm.h"
>  #include "css.h"
> +#include "vfio_ccw_parent.h"
>  #include "vfio_ccw_private.h"
>  
>  struct workqueue_struct *vfio_ccw_work_q;
> @@ -36,7 +37,8 @@ debug_info_t *vfio_ccw_debug_trace_id;
>   */
>  int vfio_ccw_sch_quiesce(struct subchannel *sch)
>  {
> -	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
> +	struct vfio_ccw_parent *parent = dev_get_drvdata(&sch->dev);
> +	struct vfio_ccw_private *private = dev_get_drvdata(&parent->dev);
>  	DECLARE_COMPLETION_ONSTACK(completion);
>  	int iretry, ret = 0;
>  
> @@ -51,19 +53,21 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
>  			break;
>  		}
>  
> -		/*
> -		 * Flush all I/O and wait for
> -		 * cancel/halt/clear completion.
> -		 */
> -		private->completion = &completion;
> -		spin_unlock_irq(sch->lock);
> +		if (private) {

Is it valid to ever reach this code with private == NULL?  If no, then this should probably be a WARN_ON upfront?

> +			/*
> +			 * Flush all I/O and wait for
> +			 * cancel/halt/clear completion.
> +			 */
> +			private->completion = &completion;
> +			spin_unlock_irq(sch->lock);
>  
> -		if (ret == -EBUSY)
> -			wait_for_completion_timeout(&completion, 3*HZ);
> +			if (ret == -EBUSY)
> +				wait_for_completion_timeout(&completion, 3*HZ);
>  
> -		private->completion = NULL;
> -		flush_workqueue(vfio_ccw_work_q);
> -		spin_lock_irq(sch->lock);
> +			private->completion = NULL;
> +			flush_workqueue(vfio_ccw_work_q);
> +			spin_lock_irq(sch->lock);
> +		}
>  		ret = cio_disable_subchannel(sch);
>  	} while (ret == -EBUSY);
>  

.. snip ..

> diff --git a/drivers/s390/cio/vfio_ccw_parent.h b/drivers/s390/cio/vfio_ccw_parent.h
> new file mode 100644
> index 000000000000..834c00077802
> --- /dev/null
> +++ b/drivers/s390/cio/vfio_ccw_parent.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * MDEV Parent contents for vfio_ccw driver
> + *
> + * Copyright IBM Corp. 2022
> + */
> +
> +#ifndef _VFIO_CCW_PARENT_H_
> +#define _VFIO_CCW_PARENT_H_
> +
> +#include <linux/mdev.h>
> +
> +/**
> + * struct vfio_ccw_parent
> + *
> + * @dev: embedded device struct
> + * @parent: parent data structures for mdevs created
> + * @mdev_type(s): identifying information for mdevs created
> + */
> +struct vfio_ccw_parent {
> +	struct device		dev;
> +
> +	struct mdev_parent	parent;
> +	struct mdev_type	mdev_type;
> +	struct mdev_type	*mdev_types[1];
> +};

Structure itself seems fine, but any reason we need a new file for it?



