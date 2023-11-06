Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9317E2A46
	for <lists+linux-s390@lfdr.de>; Mon,  6 Nov 2023 17:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjKFQs3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Nov 2023 11:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjKFQs2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 11:48:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC2D47;
        Mon,  6 Nov 2023 08:48:26 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6GCS9b013136;
        Mon, 6 Nov 2023 16:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=7bawgm6MAn1NPLnyFmOqiHfQCmL+UtH3iOqkBkNV4fc=;
 b=HY7vOFxH+JAwC0HTzzHMyHA7j8CUM42xR+8Tx9Zzeo3kFEGyvcFT7SUZ+xSeUOKqQOoN
 3Teq3t9VjGVYwTZ+u1EYK4LOQDrAJGr9NcjEZMgdBRoCd26yem1J1oTb98HnBdMF0bX6
 chOnhzyzw7nvcBFKZKCSi+8EHuVW51UXEailhbyimDM0T++pEhDeHEtpKYc11fbVqRXh
 aliYRp6COcxX1vDuG/7xko7cwdBQxAB93wEILgWYW4xVaiz35WElF03Y0DwceSV09P5v
 4cYwbt1DIntrREhc1/YTtZNYYaflY9JxlZZ7YHxLnp/WVMRB++MGwZPiYySjr2Ds6nmq Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73f4hbjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:48:25 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6GfrD3013600;
        Mon, 6 Nov 2023 16:48:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73f4hbjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:48:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FwjEG007908;
        Mon, 6 Nov 2023 16:48:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u60nyau8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:48:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6GmKUU52101470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 16:48:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 861262004B;
        Mon,  6 Nov 2023 16:48:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 560B020043;
        Mon,  6 Nov 2023 16:48:20 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 16:48:20 +0000 (GMT)
Date:   Mon, 6 Nov 2023 17:48:19 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     frankja@linux.ibm.com, thuth@redhat.com, hca@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v8 7/8] s390x: add a test for SIE without
 MSO/MSL
Message-ID: <20231106174819.79c23d31@p-imbrenda>
In-Reply-To: <20231106163738.1116942-8-nrb@linux.ibm.com>
References: <20231106163738.1116942-1-nrb@linux.ibm.com>
        <20231106163738.1116942-8-nrb@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RAVvFm6-k4adb1rx45y6skzgauREY4W_
X-Proofpoint-ORIG-GUID: QvNul62KR2CsLQ5ifNbLLl39FIZ-v9YU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=869 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon,  6 Nov 2023 17:37:29 +0100
Nico Boehr <nrb@linux.ibm.com> wrote:

> Since we now have the ability to run guests without MSO/MSL, add a test
> to make sure this doesn't break.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

