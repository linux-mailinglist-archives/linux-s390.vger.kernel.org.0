Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D089493B5D
	for <lists+linux-s390@lfdr.de>; Wed, 19 Jan 2022 14:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbiASNrH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 19 Jan 2022 08:47:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236230AbiASNrG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Jan 2022 08:47:06 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JDT4oa004740;
        Wed, 19 Jan 2022 13:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YkJC5ufyIJ7odpcEovakSnN6VL47BQcgEbKqHQVgTDg=;
 b=sjgqPecy0cb4oan9uXp7ydoYGYXk9p0H0mS0d3ytjifboksWjAaX5hQatubOWdhuw+VF
 nkJcPhduTCKIXTVCnHA2XCi2Wnkh5AS6Y69IBg0FZ1QGlNZUsplS5LrszCo4J8fi6BsW
 sXjg2nKbmsZirGkaEGVO4pUIVVSSyHCMcIfH7ZxzR5/Xpr52jX6mbLURvPZGh+QC67YK
 EJoPWm4pyu0tRIpzRxx+9Q5vz1j9pAF/8tk+UZV7nK73lxFbH3RoQnPYC2MQe88ACUnQ
 LfO5IX6lxMO++XZPAE9rSY7+VewBnMhpCswaIBfnHw0i4eNOpA+HnMIj1t+vYcQFwAbI fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpkjb0c7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 13:47:06 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20JDZc8o008343;
        Wed, 19 Jan 2022 13:47:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpkjb0c6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 13:47:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JDhiSm020558;
        Wed, 19 Jan 2022 13:47:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3dknw9e9wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 13:47:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JDl09544106180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 13:47:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 157D4A4065;
        Wed, 19 Jan 2022 13:47:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A6E9A405F;
        Wed, 19 Jan 2022 13:46:59 +0000 (GMT)
Received: from [9.171.7.240] (unknown [9.171.7.240])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jan 2022 13:46:59 +0000 (GMT)
Message-ID: <cf373eb1-02d2-387c-208d-d6dbb24cc64a@linux.ibm.com>
Date:   Wed, 19 Jan 2022 14:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 28/30] vfio-pci/zdev: add DTSM to clp group capability
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220114203145.242984-1-mjrosato@linux.ibm.com>
 <20220114203145.242984-29-mjrosato@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220114203145.242984-29-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iYBxSG5dYL4GzuPdkMQKVUOzCUjf0xjJ
X-Proofpoint-GUID: pq1B-2MP5nMgq8iOce4jvm9XAmcmHRix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_08,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190078
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 1/14/22 21:31, Matthew Rosato wrote:
> The DTSM, or designation type supported mask, indicates what IOAT formats
> are available to the guest.  For an interpreted device, userspace will not
> know what format(s) the IOAT assist supports, so pass it via the
> capability chain.  Since the value belongs to the Query PCI Function Group
> clp, let's extend the existing capability with a new version.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>



> ---
>   drivers/vfio/pci/vfio_pci_zdev.c | 9 ++++++---
>   include/uapi/linux/vfio_zdev.h   | 3 +++
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 2b169d688937..aa2ef9067c7d 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -45,19 +45,22 @@ static int zpci_group_cap(struct zpci_dev *zdev, struct vfio_info_cap *caps)
>   {
>   	struct vfio_device_info_cap_zpci_group cap = {
>   		.header.id = VFIO_DEVICE_INFO_CAP_ZPCI_GROUP,
> -		.header.version = 1,
> +		.header.version = 2,
>   		.dasm = zdev->dma_mask,
>   		.msi_addr = zdev->msi_addr,
>   		.flags = VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH,
>   		.mui = zdev->fmb_update,
>   		.noi = zdev->max_msi,
>   		.maxstbl = ZPCI_MAX_WRITE_SIZE,
> -		.version = zdev->version
> +		.version = zdev->version,
> +		.dtsm = 0
>   	};
>   
>   	/* Some values are different for interpreted devices */
> -	if (zdev->kzdev && zdev->kzdev->interp)
> +	if (zdev->kzdev && zdev->kzdev->interp) {
>   		cap.maxstbl = zdev->maxstbl;
> +		cap.dtsm = kvm_s390_pci_get_dtsm(zdev);
> +	}
>   
>   	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
>   }
> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
> index 1a5229b7bb18..b4c2ba8e71f0 100644
> --- a/include/uapi/linux/vfio_zdev.h
> +++ b/include/uapi/linux/vfio_zdev.h
> @@ -47,6 +47,9 @@ struct vfio_device_info_cap_zpci_group {
>   	__u16 noi;		/* Maximum number of MSIs */
>   	__u16 maxstbl;		/* Maximum Store Block Length */
>   	__u8 version;		/* Supported PCI Version */
> +	/* End of version 1 */
> +	__u8 dtsm;		/* Supported IOAT Designations */
> +	/* End of version 2 */
>   };
>   
>   /**
> 

-- 
Pierre Morel
IBM Lab Boeblingen
