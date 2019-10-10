Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD93D1EAC
	for <lists+linux-s390@lfdr.de>; Thu, 10 Oct 2019 04:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfJJCvV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Oct 2019 22:51:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47010 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJJCvU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 22:51:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so2887900pfg.13
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 19:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0sMKEV5b0pk9ztiAmXIaYlOQm0iymGEDt+OeeonaAuk=;
        b=XW9XaeruM1KBX2wkpvociay3WFnfSvsGUazRb9bhX7W5IdXrs8bhLLhDQzXrM3p5Ym
         qDRVBe8IqfIlBvm5rEcMaiEqXZ//KxNyMkTGFDTJYs/3AxuShPmd/78jYO2i+XqCYskm
         e2O+z2OwQvOD5Xg/CSXlf5siu/s9yovdL0BpGd1Ij3TXxRcxcgWrPnJU+7t3gH1nOprY
         a3kfW4zv1MEVjsebSozBTZGhtnXMXIItiedxZimMfj2RgnW9nkDYhlfiayW8x9KaFyQ+
         rUVKgoHBR+R3n13jHkhKS//mE6WUcEGiYbZu8xRHLyldShoZB2LZI2DAVpjZUrtSg77t
         VljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0sMKEV5b0pk9ztiAmXIaYlOQm0iymGEDt+OeeonaAuk=;
        b=Z1On+0307goZBj2ry9iZ1WPYpiteaxio2QO+oyiPwlVSCepVNbyPv77V1zzkuI0wR6
         nAwPUTH2kXZV7KM57z+OPM7DoJrJT/Emo95eiooTTa+I90MCynE1HYdj5a8Q5Q6i+h31
         0NXMTecZsIsU3PjNZPxoeSE9t9Sg+DuaRKLDgnllQkYj6f7OYDmuS03h4fEKsZLfiQDa
         Hbo4IoNgxjywbjyXYmKDTRS6i3tUN6Lv7P1Edcx/U/E1ygUsAE+3/ffrl13Lrtj3gLlv
         GCc+OL9PaRo5LSIAzeNLkWKhM6HSf8mpqTJCUmB6s21la/qPWxi1hsa/Hoa9gRA4i6Mt
         bDxw==
X-Gm-Message-State: APjAAAU5uTg/hfkLQtdqK6zGV7cu6X55mOHVcMVgiv3Nqb58yqo4QMo2
        d6NPK8w/GTbL6yMalZyH/jCbqQ==
X-Google-Smtp-Source: APXvYqy3hCziVPJ57JZI/NWxnxZ0VmC/ukaKVlA1T8bIBfGXEB+clb7sdJWgteRienn7beddmHvXVg==
X-Received: by 2002:a63:df42:: with SMTP id h2mr7508588pgj.405.1570675880020;
        Wed, 09 Oct 2019 19:51:20 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id z189sm3467366pgz.53.2019.10.09.19.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 19:51:19 -0700 (PDT)
Date:   Wed, 9 Oct 2019 19:51:06 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, gor@linux.ibm.com,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        ubraun@linux.ibm.com
Subject: Re: [PATCH net-next 0/5] net/smc: improve termination handling
Message-ID: <20191009195106.081db8d8@cakuba.netronome.com>
In-Reply-To: <20191009080747.95516-1-kgraul@linux.ibm.com>
References: <20191009080747.95516-1-kgraul@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  9 Oct 2019 10:07:42 +0200, Karsten Graul wrote:
> First set of patches to improve termination handling.

Applied, thanks.

Out of curiosity why does net/sock.h have to include net/smc.h?
This SMC-specific series causes half of the kernel to rebuild =F0=9F=A4=A8
