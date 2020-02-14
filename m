Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0594215DB00
	for <lists+linux-s390@lfdr.de>; Fri, 14 Feb 2020 16:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgBNPcR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 14 Feb 2020 10:32:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgBNPcR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 10:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581694336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpSVv8LaGjL/WOEMCp7PdMztRTC66Pi1pm1c62D++2s=;
        b=KHGHv3lD2OKvQC5oitBpleDcO3XnEu0P8uxignfBpe0mNr7MFBVXCR2rUZ7ti1FU6g4MI8
        OeDQLsaLRuALLfSweW9IAV7/5o69/PMmI9r58ys1y07QrD3Fglf3B17/ibvUTVdiAS7Vas
        QhsRnjh+xOzrifn135e6LkSA8cbMK8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-2amzhSGZO2ayyQn8CWHXYQ-1; Fri, 14 Feb 2020 10:32:15 -0500
X-MC-Unique: 2amzhSGZO2ayyQn8CWHXYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 370D3107ACCC;
        Fri, 14 Feb 2020 15:32:13 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EC5B17DC8;
        Fri, 14 Feb 2020 15:32:11 +0000 (UTC)
Date:   Fri, 14 Feb 2020 16:32:09 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     qiwuchen55@gmail.com
Cc:     sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v2] s390/cio: use kobj_to_dev() API
Message-ID: <20200214163209.5b5e9833.cohuck@redhat.com>
In-Reply-To: <1581688293-17283-1-git-send-email-qiwuchen55@gmail.com>
References: <1581688293-17283-1-git-send-email-qiwuchen55@gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 14 Feb 2020 21:51:33 +0800
qiwuchen55@gmail.com wrote:

> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> Signed-off-by: chenqiwu <qiwuchen55@gmail.com>
> ---
> changes in v2:
>  - add signed off for my gmail adderss.
> --- 
>  drivers/s390/cio/chp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

